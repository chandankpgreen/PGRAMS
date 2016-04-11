<%@ Page Title="" Language="C#" MasterPageFile="~/Auditor.master" AutoEventWireup="true" CodeFile="Complaints.aspx.cs" Inherits="AuditorPortal_Complaints" %>

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
    <table style="padding:5px">
        <tr>
            <td>
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by ComplaintID or Description" CssClass="txtSearch" Width="400px"></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
            </td>
            <td>
                <asp:DropDownList CssClass="dropdown-menu dropdown-menu-site" ID="ddlResolutionStatus" runat="server" OnSelectedIndexChanged="ddlResolutionStatus_SelectedIndexChanged" AutoPostBack="True">
                    <asp:ListItem Value="1" Selected="True">Created</asp:ListItem>
                    <asp:ListItem Value="2">In Review</asp:ListItem>
                    <asp:ListItem Value="3">Surveyed</asp:ListItem>
                    <asp:ListItem Value="11">Complainant Unsatisfied/Shoddy work</asp:ListItem>
                    <asp:ListItem Value="12">Did not address in time/Ignored</asp:ListItem>
                    <asp:ListItem Value="13">On Hold</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>

    <div id="button-actions" style="margin-bottom: 20px; margin-top: 20px" class="hidden">
        <div id="btnMoveToReview" class="btn btn-success">Move to reviewed</div>
        <div id="btnMoveToSurveyed" class="btn btn-success">Move to surveyed</div>
        <div id="btnMoveToApproved" class="btn btn-success">Approve Complaint</div>
        <div id="btnMoveToRejected" class="btn btn-danger">Reject Complaint</div>
    </div>
    <h4>Your Grievances Listed:</h4>
    <asp:GridView ID="grdComplaints" runat="server" BackColor="#FCF8E3" CellPadding="5" AllowPaging="True" EmptyDataText="No Complaints found!" Font-Names="Open Sans,Segoe UI" CssClass="grid-grievances" Width="100%" AutoGenerateColumns="False" PagerSettings-FirstPageText="First" PagerSettings-LastPageText="Last" PagerStyle-BackColor="#FFCCCC" AllowSorting="True" OnPageIndexChanging="grdComplaints_PageIndexChanging" OnSorting="grdComplaints_Sorting">
        <AlternatingRowStyle BackColor="#F2DEDE" />
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="ckbSelectGrievance" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="GrievanceID" HeaderText="Grievance ID" SortExpression="GrievanceID">
                <HeaderStyle Height="20px" VerticalAlign="Middle" Width="12%" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="GrievanceType" HeaderText="Grievance Type" SortExpression="GrievanceType">
                <HeaderStyle Width="11%" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="GrievanceDescription" HeaderText="Grievance Description" SortExpression="GrievanceDescription">
                <HeaderStyle Width="17%" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="DateLogged" HeaderText="Date of Logging" SortExpression="DateLogged">
                <HeaderStyle Width="15%" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="TargetCompletionDate" HeaderText="Target Completion Date" SortExpression="TargetCompletionDate">
                <HeaderStyle Width="18%" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="ResolutionStatus" HeaderText="Status">
                <HeaderStyle Width="15%" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location">
                <HeaderStyle Width="25%" Wrap="False" />
            </asp:BoundField>
            <asp:ImageField DataImageUrlField="Picture" HeaderText="Picture" NullDisplayText="No Image" ReadOnly="True" DataImageUrlFormatString="~/Content/Grievances/Images/{0}">
                <ControlStyle Height="100px" Width="100px" />
                <HeaderStyle Wrap="False" />
                <ItemStyle Height="50px" Width="50px" />
            </asp:ImageField>
        </Columns>
        <HeaderStyle BackColor="#337AB7" ForeColor="White" />

        <PagerSettings FirstPageText="First" LastPageText="Last"></PagerSettings>

        <PagerStyle BackColor="#337AB7" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False"></PagerStyle>
    </asp:GridView>

    <!-- Modal -->
    <div id="modal-Reviewed" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirmation</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to move this to Reviewed?</p>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnReviewedConfirm" runat="server" CssClass="btn btn-primary" Text="Yes" OnClick="btnReviewedConfirm_Click" />
                    <div class="btn btn-danger" data-dismiss="modal">No</div>
                </div>
            </div>

        </div>
    </div>
    <div id="modal-Surveyed" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirmation</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to move this to Surveyed?</p>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnSurveyedConfirm" runat="server" CssClass="btn btn-primary" Text="Yes" OnClick="btnSurveyedConfirm_Click" />
                    <div class="btn btn-danger" data-dismiss="modal">No</div>
                </div>
            </div>

        </div>
    </div>
    <div id="modal-Approved" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirmation</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to mark this Grievance as approved?</p>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnApprovedConfirm" runat="server" CssClass="btn btn-primary" Text="Yes" OnClick="btnApprovedConfirm_Click" />
                    <div class="btn btn-danger" data-dismiss="modal">No</div>
                </div>
            </div>

        </div>
    </div>
    <div id="modal-Rejected" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirmation</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to reject these Complaint(s)?</p>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnRejectConfirm" runat="server" CssClass="btn btn-primary" Text="Yes" OnClick="btnRejectConfirm_Click" />
                    <div class="btn btn-danger" data-dismiss="modal">No</div>
                </div>
            </div>

        </div>
    </div>
    <script type="text/javascript">
        function SetButtonStatus() {
        
            switch(parseInt($("#<%=ddlResolutionStatus.ClientID%>").val())){
                case 1:
                case 11:
                case 12:
                case 13:
                    $("#btnMoveToReview").removeClass("disabled");
                    $("#btnMoveToSurveyed").addClass("disabled");
                    $("#btnMoveToApproved").addClass("disabled");
                    $("#btnMoveToRejected").addClass("disabled");
                    break;
                case 2:
                    $("#btnMoveToReview").addClass("disabled");
                    $("#btnMoveToSurveyed").removeClass("disabled");
                    $("#btnMoveToApproved").addClass("disabled");
                    $("#btnMoveToRejected").addClass("disabled");
                    break;
                case 3:
                    $("#btnMoveToReview").addClass("disabled");
                    $("#btnMoveToSurveyed").addClass("disabled");
                    $("#btnMoveToApproved").removeClass("disabled");
                    $("#btnMoveToRejected").removeClass("disabled");
                    break;
                default:                                                                        
                    $("#btnMoveToReview").addClass("disabled");
                    $("#btnMoveToSurveyed").addClass("disabled");
                    $("#btnMoveToApproved").addClass("disabled");
                    $("#btnMoveToRejected").addClass("disabled");
                    break;
            }
        }

        $(document).ready(function () {
            var $selectionCheckboxes = $("#<%=grdComplaints.ClientID%>").find("input[type=checkbox]");
            $selectionCheckboxes.off("change").on("change", function () {
                if ($selectionCheckboxes.filter(function () {
                    if ($(this).prop("checked")) {
                        return true;
                }
                }).length > 0) {
                    $("#button-actions").removeClass("hidden");
                    SetButtonStatus();
                }
                else {
                    $("#button-actions").addClass("hidden");
                }
            });

            $("#btnMoveToReview").off("click").on("click", function () {
                $("#modal-Reviewed").modal("show");
            });
            $("#btnMoveToSurveyed").off("click").on("click", function () {
                $("#modal-Surveyed").modal("show");
            });
            $("#btnMoveToApproved").off("click").on("click", function () {
                $("#modal-Approved").modal("show");
            });
            $("#btnMoveToRejected").off("click").on("click", function () {
                $("#modal-Rejected").modal("show");
            });
        });
    </script>
</asp:Content>

