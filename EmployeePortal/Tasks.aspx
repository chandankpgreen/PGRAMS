<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeeMaster.master" AutoEventWireup="true" CodeFile="Tasks.aspx.cs" Inherits="EmployeePortal_Tasks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:PlaceHolder runat="server" ID="ErrorPlaceHolder" Visible="false">
        <div class="alert alert-danger">
            <asp:Literal runat="server" ID="ErrorMessage" />
        </div>
    </asp:PlaceHolder>
    <asp:PlaceHolder runat="server" ID="SuccessPlaceHolder" Visible="false">
        <div class="alert alert-success">
            <asp:Literal runat="server" ID="SuccessMessage" />
        </div>
    </asp:PlaceHolder>
    <table style="padding: 5px">
        <tr>
            <td>Select Task Status :
            </td>
            <td>
                <asp:DropDownList CssClass="dropdown-menu dropdown-menu-site" ID="ddlResolutionStatus" runat="server" OnSelectedIndexChanged="ddlResolutionStatus_SelectedIndexChanged" AutoPostBack="True">
                    <asp:ListItem Value="0" Selected="True">To be Started</asp:ListItem>
                    <asp:ListItem Value="1">Started</asp:ListItem>
                    <asp:ListItem Value="2">In Progress</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <div id="button-actions" style="margin-bottom: 20px; margin-top: 20px" class="hidden">
        <div id="btnStarted" class="btn btn-success">Start working on selected Task(s)</div>
        <div id="btnInProgress" class="btn btn-success">Mark selected task(s) as In Progress</div>
        <div id="btnCompleted" class="btn btn-success">Mark selected tasks as Complete</div>
    </div>

    <asp:GridView ID="grdTasks" runat="server" BackColor="#FCF8E3" CellPadding="5" EmptyDataText="No Tasks found!" Font-Names="Open Sans,Segoe UI" CssClass="grid-grievances" Width="100%" AutoGenerateColumns="False" OnRowDataBound="grdTasks_RowDataBound">
        <AlternatingRowStyle BackColor="#F2DEDE" />
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="ckbSelectTask" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="TaskID" HeaderText="TaskID" />
            <asp:BoundField DataField="TaskDescription" HeaderText="Task Description" />
            <asp:BoundField DataField="TaskBudget" HeaderText="Task Budget" />
            <asp:BoundField DataField="MenReqired" HeaderText="Men Required" />
            <asp:BoundField DataField="TargetStartDate" HeaderText="Target Start Date" />
            <asp:BoundField DataField="TargetCompletionDate" HeaderText="Target Completion Date" />
            <asp:BoundField DataField="Comments" HeaderText="Comments" />
            <asp:BoundField DataField="Status" HeaderText="Status" />
        </Columns>
        <HeaderStyle BackColor="#337AB7" ForeColor="White" />
    </asp:GridView>
    <div id="modal-StartWorking" class="modal fade" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Confirmation</h4>
          </div>
          <div class="modal-body">
            <p>Are you sure you want to start working on selected Task(s)?</p>
          </div>
          <div class="modal-footer">
            <asp:Button ID="btnStartConfirm" runat="server" CssClass="btn btn-primary" Text="Yes" OnClick="btnStartConfirm_Click"/>
              <div class="btn btn-danger" data-dismiss="modal">No</div>
          </div>
        </div>

      </div>
    </div>
      <div id="modal-InProgress" class="modal fade" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Confirmation</h4>
          </div>
          <div class="modal-body">
            <p>Are you sure you want to move selected tasks to In Progress?</p>
          </div>
          <div class="modal-footer">
            <asp:Button ID="btnInProgressConfirm" runat="server" CssClass="btn btn-primary" Text="Yes" OnClick="btnInProgressConfirm_Click"/>
              <div class="btn btn-danger" data-dismiss="modal">No</div>
          </div>
        </div>

      </div>
    </div>
    <div id="modal-Complete" class="modal fade" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Confirmation</h4>
          </div>
          <div class="modal-body">
            <p>Are you sure you want to mark selected task(s) as complete?</p>
          </div>
          <div class="modal-footer">
            <asp:Button ID="btnCompleteConfirm" runat="server" CssClass="btn btn-primary" Text="Yes" OnClick="btnCompleteConfirm_Click"/>
              <div class="btn btn-danger" data-dismiss="modal">No</div>
          </div>
        </div>

      </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
            var $selectionCheckboxes = $("#<%=grdTasks.ClientID%>").find("input[type=checkbox]");
            $selectionCheckboxes.off("change").on("change", function () {
                if ($selectionCheckboxes.filter(function () {
                    if ($(this).prop("checked")) {
                        return true;
                }
                }).length > 0) {
                    $("#button-actions").removeClass("hidden");
                    var enablestarted = false;
                    var enableinprogress = false;
                    var enablecompleted = false;
                    if ($("#<%=ddlResolutionStatus.ClientID%>").val() == "0") {
                        $("#btnStarted").removeClass("disabled");
                        $("#btnInProgress").addClass("disabled");
                        $("#btnCompleted").addClass("disabled");
                    }
                    else if ($("#<%=ddlResolutionStatus.ClientID%>").val() == "1") {
                        $("#btnStarted").addClass("disabled");
                        $("#btnInProgress").removeClass("disabled");
                        $("#btnCompleted").addClass("disabled");
                    }
                    else if ($("#<%=ddlResolutionStatus.ClientID%>").val() == "2") {
                        $("#btnStarted").addClass("disabled");
                        $("#btnInProgress").addClass("disabled");
                        $("#btnCompleted").removeClass("disabled");
                    }

            }
            else {
                $("#button-actions").addClass("hidden");
            }
            });
            $("#btnStarted").off("click").on("click", function () {
                $("#modal-StartWorking").modal("show");
            });
            $("#btnInProgress").off("click").on("click", function () {
                $("#modal-InProgress").modal("show");
            });
            $("#btnCompleted").off("click").on("click", function () {
                $("#modal-Complete").modal("show");
            });
        });
    </script>

</asp:Content>

