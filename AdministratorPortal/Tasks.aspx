<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator.master" AutoEventWireup="true" CodeFile="Tasks.aspx.cs" Inherits="AdministratorPortal_Tasks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h4>Complaints:</h4> : <asp:DropDownList ID="ddlComplaints" runat="server" OnSelectedIndexChanged="ddlComplaints_SelectedIndexChanged"></asp:DropDownList>
    <hr />
    <h4>Tasks for this Complaint listed :</h4>
    <asp:GridView ID="grdTasks" runat="server" BackColor="#FCF8E3" CellPadding="5" AllowPaging="True"  Font-Names="Open Sans,Segoe UI" CssClass="grid-grievances" Width="100%" AutoGenerateColumns="False" PagerSettings-FirstPageText="First" PagerSettings-LastPageText="Last" PagerStyle-BackColor="#FFCCCC" AllowSorting="True">
        <AlternatingRowStyle BackColor="#F2DEDE" />
        <Columns>
            <asp:BoundField DataField="TaskID" HeaderText="Task ID" SortExpression="TaskID" />
            <asp:BoundField HeaderText="Description" DataField="TaskDescription" SortExpression="TaskDescription" />
            <asp:BoundField HeaderText="Target Start Date" DataField="TargetStartDate" SortExpression="TargetStartDate" />
            <asp:BoundField HeaderText="Target Complettion Date" DataField="TargetCompletionDate" SortExpression="TargetCompletionDate" />
            <asp:BoundField HeaderText="Men Reqired" DataField="MenReqired" SortExpression="MenReqired" />
            <asp:BoundField HeaderText="Budget" DataField="TaskBudget" DataFormatString="Rs.{0:##,##,###.00}" SortExpression="TaskBudget" />
            <asp:BoundField HeaderText="Comments" DataField="Comments" SortExpression="Comments" />
            <asp:BoundField HeaderText="Assigned to" DataField="Resolver" SortExpression="Resolver" />
            <asp:BoundField HeaderText="Status" DataField="Status" SortExpression="Status" />
        </Columns>
        <EmptyDataTemplate>
            <asp:Literal ID="Literal1" runat="server" Text="No tasks for the selected Grievance"></asp:Literal>
        </EmptyDataTemplate>
                <HeaderStyle BackColor="#337AB7" ForeColor="White" />

        <PagerSettings FirstPageText="First" LastPageText="Last"></PagerSettings>

        <PagerStyle BackColor="#337AB7" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False"></PagerStyle>
    </asp:GridView>
    <div id="btnCreateTask" class="btn btn-success">Create Task</div>
      <div id="modal-Task" class="modal fade" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Confirmation</h4>
          </div>
          <div class="modal-body">
            <table>
                <tr>
                    <td>Task Description</td>
                    <td>
                        <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Employee to Assign this:</td>
                    <td>
                        <asp:DropDownList ID="ddlEmployee" runat="server"></asp:DropDownList></td>
                </tr>
                <tr>
                    <td>Task Budget in Rupees</td>
                    <td><asp:TextBox ID="txtBudget" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Men Required</td>
                    <td><asp:TextBox ID="txtMenRequired" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Target Start date</td>
                    <td>
                        <asp:Calendar ID="calStartDate" runat="server"></asp:Calendar>
                    </td>
                </tr>
                <tr>
                    <td>Target Completion date</td>
                    <td><asp:Calendar ID="calCompletionDate" runat="server"></asp:Calendar></td>
                </tr>
                <tr>
                    <td>Comments</td>
                    <td><asp:TextBox ID="txtComments" runat="server"></asp:TextBox></td>
                </tr>
            </table>
          </div>
          <div class="modal-footer">
              <asp:Button ID="btnCreate" class="btn btn-primary" runat="server" Text="Create" OnClick="btnCreate_Click" />
              <div class="btn btn-danger" data-dismiss="modal">Cancel</div>
          </div>
        </div>

      </div>
    </div>
    <script type="text/javascript">
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode != 46 && charCode > 31
              && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }
        $(document).ready(function () {
            $("#btnCreateTask").off("click").on("click", function () {
                $("#modal-Task").modal("show");
            });
            $("#<%=txtMenRequired%>", "#<%=txtBudget%>").off("keypress").on("keypress", function () {
                return isNumberKey(event);
            })
        });
    </script>
</asp:Content>

