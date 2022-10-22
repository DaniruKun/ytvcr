defmodule Ytvcr.YtarchiveAdapter do
  use GenServer

  require Logger

  @default_max_recording_length :timer.hours(2)

  @spec start_link(list(String.t())) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  @impl true
  def init(args) do
    state = %{
      port: nil,
      timer: nil,
      cmd_args: args
    }

    {:ok, state, {:continue, :start_ytarchive}}
  end

  @impl true
  def handle_continue(:start_ytarchive, state = %{cmd_args: cmd_args}) do
    {:ok, port} = Ytvcr.Ytarchive.execute(cmd_args)
    timeout = Application.get_env(:ytvcr, :max_recording_length, @default_max_recording_length)
    timer = Process.send_after(self(), :stop, timeout)
    {:noreply, %{state | port: port, timer: timer}}
  end

  @impl true
  def handle_info({_port, {:data, msg}}, state) do
    # Logger.debug("#{__MODULE__}: Received message from port: #{msg}")
    {:noreply, state}
  end

  @impl true
  def handle_info(:stop, %{port: port} = state) do
    Logger.warn("#{__MODULE__}: Stopping after timeout")
    Ytvcr.Helpers.stop_port_process(port)
    {:noreply, state}
  end

  @impl true
  def handle_info(_msg, state) do
    Logger.warn("#{__MODULE__}: Received unknown message")
    {:ok, state}
  end
end
