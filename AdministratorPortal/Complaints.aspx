<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator.master" AutoEventWireup="true" CodeFile="Complaints.aspx.cs" Inherits="AuditorPortal_Complaints" %>

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
                    <asp:ListItem Value="4" Selected="True">Approved</asp:ListItem>
                    <asp:ListItem Value="7">Started working on the Complaint</asp:ListItem>
                    <asp:ListItem Value="8">Complaint Resolution in Progress</asp:ListItem>
                    <asp:ListItem Value="9">Completed implementation</asp:ListItem>
                    <asp:ListItem Value="6">Cancelled(For lack of funds/inventory/manpower etc.)</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>

 
    <h4>Grievances Listed:</h4>
    <asp:GridView ID="grdComplaints" runat="server" BackColor="#FCF8E3" CellPadding="5" AllowPaging="True" EmptyDataText="No Complaints found!" Font-Names="Open Sans,Segoe UI" CssClass="grid-grievances" Width="100%" OnRowDataBound="grdComplaints_RowDataBound" AutoGenerateColumns="False" PagerSettings-FirstPageText="First" PagerSettings-LastPageText="Last" PagerStyle-BackColor="#FFCCCC" AllowSorting="True" OnPageIndexChanging="grdComplaints_PageIndexChanging" OnRowCreated="grdComplaints_RowCreated" OnSorting="grdComplaints_Sorting">
        <AlternatingRowStyle BackColor="#F2DEDE" />
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnCreateTasks" runat="server" Text="Create Tasks" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:Button ID="btnViewTasks" runat="server" Text="View Tasks" />
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
            <asp:BoundField DataField="ResolutionStatus" HeaderText="Status" SortExpression="ResolutionStatus">
                <HeaderStyle Width="15%" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments">
                <HeaderStyle Width="25%" Wrap="False" />
            </asp:BoundField>
        </Columns>
        <HeaderStyle BackColor="#337AB7" ForeColor="White" />

        <PagerSettings FirstPageText="First" LastPageText="Last"></PagerSettings>

        <PagerStyle BackColor="#337AB7" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False"></PagerStyle>
    </asp:GridView>

    <script type="text/javascript">

        $(document).ready(function () {
            var $selectionCheckboxes = $(".grid-grievances").find("input[type=checkbox]");
            $selectionCheckboxes.off("change").on("change", function () {
                if ($selectionCheckboxes.filter(function () {
                    if ($(this).prop("checked")) {
                        return true;
                }
                }).length > 0) {
                    $("#button-actions").removeClass("hidden");
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
        });
    </script>
</asp:Content>

