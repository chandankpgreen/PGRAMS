<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator.master" AutoEventWireup="true" CodeFile="Reports.aspx.cs" Inherits="AdministratorPortal_Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
        <div class="alert alert-danger hidden" id="taskalert">
            <asp:Literal runat="server" ID="ErrorMessage" />
        </div>
    <table class="table-padded" style="margin-top: 10px; width: 60%;padding:10px">
        <tr>
            <td style="width:40%;padding:10px">Select report :
            </td>
            <td style="padding:10px">
                <asp:DropDownList ID="ddlReport" CssClass="dropdown-menu dropdown-menu-site" runat="server">
                    <asp:ListItem>Employee Workload</asp:ListItem>
                    <asp:ListItem>Grievance Cost Report</asp:ListItem>
                    <asp:ListItem>Departmentwise Costs incurred</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td style="padding:10px">Select date range :
            </td>
            <td style="padding:10px">
                <asp:TextBox ID="txtFromDate" runat="server"></asp:TextBox>
                &nbsp;&nbsp;to&nbsp;&nbsp;
                <asp:TextBox ID="txtEndDate" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="padding:10px">
                <asp:Button ID="btnGetReport" runat="server" CssClass="hidden" Text="Run Report" OnClick="btnGetReport_Click" />
                <asp:Button ID="btnExportReport" runat="server" CssClass="hidden" OnClick="btnExportReport_Click" Text="Export Report"></asp:Button>
                <div style="display: inline">
                    <div id="btnRunReport" class="btn btn-success" style="display: inline">Run Report</div>
                    <div id="btnReport" class="btn btn-info" style="display: inline">Export Report</div>
                </div>
            </td>
        </tr>
    </table>
    <asp:GridView ID="grdReport" runat="server" BackColor="#FCF8E3" CellPadding="5" EmptyDataText="No Rows found!" Font-Names="Open Sans,Segoe UI" CssClass="grid-grievances" Width="100%">
        <AlternatingRowStyle BackColor="#F2DEDE" />
        <HeaderStyle BackColor="#337AB7" ForeColor="White" />
    </asp:GridView>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#<%=txtFromDate.ClientID%>").datepicker({ defaultDate: 0, showMonthAfterYear: true });
            $("#<%=txtEndDate.ClientID%>").datepicker({ defaultDate: 0, showMonthAfterYear: true });
            $("#btnRunReport").off("click").on("click", function () {
                var errmsg = "";
                if (!moment($("#<%=txtFromDate.ClientID%>").val()).isValid()) {
                        errmsg += "From date is not valid.<br/>";
                }
                if (!moment($("#<%=txtEndDate.ClientID%>").val()).isValid()) {
                        errmsg += "End date is not valid.<br/>";
                }
                if (errmsg.length > 0) {
                    $("#taskalert").html(errmsg).removeClass("hidden");
                }
                else {
                    $("#taskalert").empty().addClass("hidden");
                    $("#<%=btnGetReport.ClientID%>").trigger("click");
                }

            });
            $("#btnReport").off("click").on("click", function () {
                var errmsg = "";
                if (!moment($("#<%=txtFromDate.ClientID%>").val()).isValid()) {
                    errmsg += "From date is not valid.<br/>";
                }
                if (!moment($("#<%=txtEndDate.ClientID%>").val()).isValid()) {
                    errmsg += "End date is not valid.<br/>";
                }
                if (errmsg.length > 0) {
                    $("#taskalert").html(errmsg).removeClass("hidden");
                }
                else {
                    $("#taskalert").empty().addClass("hidden");
                    $("#<%=btnExportReport.ClientID%>").trigger("click");
                }

            });
        });
    </script>
</asp:Content>

