defmodule IgIntranet.ApplicationActivityTest do
  use IgIntranet.DataCase

  alias IgIntranet.ApplicationActivity

  describe "logs" do
    alias IgIntranet.ApplicationActivity.Log

    import IgIntranet.ApplicationActivityFixtures

    @invalid_attrs %{log_event: nil, user_email: nil}

    test "list_logs/0 returns all logs" do
      log = log_fixture()
      assert ApplicationActivity.list_logs() == [log]
    end

    test "get_log!/1 returns the log with given id" do
      log = log_fixture()
      assert ApplicationActivity.get_log!(log.id) == log
    end

    test "create_log/1 with valid data creates a log" do
      valid_attrs = %{log_event: "some log_event", user_email: "some user_email"}

      assert {:ok, %Log{} = log} = ApplicationActivity.create_log(valid_attrs)
      assert log.log_event == "some log_event"
      assert log.user_email == "some user_email"
    end

    test "create_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ApplicationActivity.create_log(@invalid_attrs)
    end

    test "update_log/2 with valid data updates the log" do
      log = log_fixture()
      update_attrs = %{log_event: "some updated log_event", user_email: "some updated user_email"}

      assert {:ok, %Log{} = log} = ApplicationActivity.update_log(log, update_attrs)
      assert log.log_event == "some updated log_event"
      assert log.user_email == "some updated user_email"
    end

    test "update_log/2 with invalid data returns error changeset" do
      log = log_fixture()
      assert {:error, %Ecto.Changeset{}} = ApplicationActivity.update_log(log, @invalid_attrs)
      assert log == ApplicationActivity.get_log!(log.id)
    end

    test "delete_log/1 deletes the log" do
      log = log_fixture()
      assert {:ok, %Log{}} = ApplicationActivity.delete_log(log)
      assert_raise Ecto.NoResultsError, fn -> ApplicationActivity.get_log!(log.id) end
    end

    test "change_log/1 returns a log changeset" do
      log = log_fixture()
      assert %Ecto.Changeset{} = ApplicationActivity.change_log(log)
    end
  end
end
