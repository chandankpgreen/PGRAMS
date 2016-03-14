<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeeMaster.master" AutoEventWireup="true" CodeFile="Tasks.aspx.cs" Inherits="EmployeePortal_Tasks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
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
        <tr>
            <td>
                <div id="button-actions" style="margin-bottom: 20px; margin-top: 20px" class="hidden">
                    <div id="btnStarted" class="btn btn-success">Start working on selected Task(s)</div>
                    <div id="btnInProgress" class="btn btn-success" >Mark selected task(s) as In Progress</div>
                    <div id="btnCompleted" class="btn btn-success">Mark selected tasks as Complete</div>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:GridView ID="grdTasks" runat="server" BackColor="#FCF8E3" CellPadding="5"  EmptyDataText="No Tasks found!" Font-Names="Open Sans,Segoe UI" CssClass="grid-grievances" Width="100%" >
                    <AlternatingRowStyle BackColor="#F2DEDE" />
                    <HeaderStyle BackColor="#337AB7" ForeColor="White" />
                </asp:GridView>
            </td>
        </tr>
    </table>
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
                        $("#btnStarted").removeClass("disabled");
                        $("#btnInProgress").addClass("disabled");
                        $("#btnCompleted").addClass("disabled");
                    }
                    else if ($("#<%=ddlResolutionStatus.ClientID%>").val() == "2") {

                    }

                }
                else {
                    $("#button-actions").addClass("hidden");
                }
            });
        });
    </script>

</asp:Content>

