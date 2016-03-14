<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator.master" AutoEventWireup="true" CodeFile="Tasks.aspx.cs" Inherits="AdministratorPortal_Tasks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h4>Complaints:
        <asp:DropDownList ID="ddlComplaints" runat="server" OnSelectedIndexChanged="ddlComplaints_SelectedIndexChanged"></asp:DropDownList></h4>
    <hr />
    <h4>Tasks for this Complaint listed :</h4>
    <asp:GridView ID="grdTasks" runat="server" BackColor="#FCF8E3" CellPadding="5" Font-Names="Open Sans,Segoe UI" CssClass="grid-grievances" Width="100%" AutoGenerateColumns="False" PagerSettings-FirstPageText="First" PagerSettings-LastPageText="Last" PagerStyle-BackColor="#FFCCCC">
        <AlternatingRowStyle BackColor="#F2DEDE" />
        <Columns>
            <asp:BoundField DataField="TaskID" HeaderText="Task ID" />
            <asp:BoundField HeaderText="Description" DataField="TaskDescription" />
            <asp:BoundField HeaderText="Target Start Date" DataField="TargetStartDate" />
            <asp:BoundField HeaderText="Target Complettion Date" DataField="TargetCompletionDate" />
            <asp:BoundField HeaderText="Men Reqired" DataField="MenReqired" />
            <asp:BoundField HeaderText="Budget" DataField="TaskBudget" DataFormatString="Rs.{0:##,##,###.00}" />
            <asp:BoundField HeaderText="Comments" DataField="Comments" />
            <asp:BoundField HeaderText="Assigned to" DataField="Resolver" />
            <asp:BoundField HeaderText="Status" DataField="Status" />
        </Columns>
        <EmptyDataTemplate>
            <asp:Literal ID="Literal1" runat="server" Text="No tasks for the selected Grievance"></asp:Literal>
        </EmptyDataTemplate>
        <HeaderStyle BackColor="#337AB7" ForeColor="White" />

        <PagerStyle BackColor="#337AB7" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False"></PagerStyle>
    </asp:GridView>
    <div id="btnCreateTask" class="btn btn-success" style="margin-top: 20px">Create Task</div>
    <div id="modal-Task" class="modal fade" role="dialog">
        <div class="vertical-alignment-helper">
            <div class="modal-dialog vertical-align-center">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Edit Task</h4>
                    </div>
                    <div class="modal-body">
                        <table cellpadding="5" cellspacing="5" style="width: 100%">
                            <tr>
                                <td colspan="2">
                                    <div class="alert alert-danger" id="taskalert" style="margin-bottom: 0; margin-top: 0; display: none;">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Task Description<span class="required-asterisk">*</span></td>
                                <td>
                                    <asp:TextBox ID="txtDescription" TextMode="MultiLine" Rows="5" Columns="40" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>Employee to Assign this:<span class="required-asterisk">*</span></td>
                                <td>
                                    <asp:DropDownList ID="ddlEmployee" runat="server"></asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td>Task Budget in Rupees<span class="required-asterisk">*</span></td>
                                <td>
                                    <asp:TextBox ID="txtBudget" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>Men Required<span class="required-asterisk">*</span></td>
                                <td>
                                    <asp:TextBox ID="txtMenRequired" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Target Start date<span class="required-asterisk">*</span></td>
                                <td>
                                    <asp:TextBox ID="txtTargetStartDate" TextMode="Date" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Target Completion date<span class="required-asterisk">*</span></td>
                                <td>
                                    <asp:TextBox ID="txtTargetCompletionDate" TextMode="Date" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>Comments</td>
                                <td>
                                    <asp:TextBox ID="txtComments" TextMode="MultiLine" Rows="5" Columns="40" runat="server"></asp:TextBox></td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <div class="btn btn-primary" id="btnCreateDisplay">Create</div>
                        <asp:Button ID="btnCreate" class="btn btn-primary" runat="server" Visible="false" Text="Create" OnClick="btnCreate_Click" />
                        <div class="btn btn-danger" data-dismiss="modal">Cancel</div>
                    </div>
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
        function ValidateTask() {
            var errmsg = "";
            var dateregex = new RegExp("\d{2}\/\d{2}\/\d{4}");
            if ($("#<%=txtDescription.ClientID%>").val().length === 0) {
                errmsg += "Description is required.<br/>";
            }
            if (!$("#<%=ddlEmployee.ClientID%>").val()) {
                errmsg += "The task must be assigned to an employee.<br/>";
            }
            if ($("#<%=txtBudget.ClientID%>").val().length === 0) {
                errmsg += "Task budget is required.<br/>";
            }
            if ($("#<%=txtMenRequired.ClientID%>").val().length === 0) {
                errmsg += "Please enter the number of men required to complete the task.<br/>";
            }
            if (dateregex.test($("#<%=txtTargetStartDate.ClientID%>").val())) {
                errmsg += "Invalid target start date.<br/>";
            }
            if (dateregex.test($("#<%=txtTargetCompletionDate.ClientID%>").val())) {
                errmsg += "Invalid target completion date.<br/>";
            }
            errmsg += "";
            return errmsg;
        }
        $(document).ready(function () {
            $("#btnCreateTask").off("click").on("click", function () {
                $("#modal-Task").modal("show");
            });
            $("#<%=txtMenRequired%>", "#<%=txtBudget%>").off("keypress").on("keypress", function () {
                return isNumberKey(event);
            })
            $("#btnCreateDisplay").off("click").on("click", function () {
                var errmsg = ValidateTask();
                if (errmsg.length > 0) {
                    $("#taskalert").html(errmsg).show();
                }
                else {
                    $("#taskalert").empty().hide();
                    $("#<%=btnCreate%>").trigger("click");
                }

            });
        });
    </script>
</asp:Content>

