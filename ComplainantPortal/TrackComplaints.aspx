<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="TrackComplaints.aspx.cs" Inherits="ComplainantPortal_TrackComplaints" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
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
    <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by ComplaintID or Description" CssClass="txtSearch" Width="400px"></asp:TextBox>
    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
    <div id="button-actions" style="margin-bottom:20px;margin-top:20px" class="hidden">
        <div ID="btnVerified" class="btn btn-success" title="Mark this complaint as resolved .Make sure that you are satisfied with the quality and timeliness of the job completed before clicking this.">Done! Thank You</div>
        <div ID="btnUnsatisfied"  class="btn btn-warning" title="Click this if you think the complaint was not resolved in a satisfactory way." >Shoddy Work, Not Satisfied</div>
        <div ID="btnIgnored"  class="btn btn-danger" title="Click this if you think the redressal department failed to take notice of this in time.">Did not start on time/Ignored</div>
    </div>
    <asp:Button ID="btnClearFilter" runat="server" Text="Clear Filter" OnClick="btnClearFilter_Click" Visible="False" />
    <h4>Your Grievances Listed:</h4>
    <asp:GridView ID="grdComplaints" runat="server" BackColor="#FCF8E3" CellPadding="5" AllowPaging="True" EmptyDataText="No Complaints found!" Font-Names="Open Sans,Segoe UI" CssClass="grid-grievances" Width="100%" OnRowDataBound="grdComplaints_RowDataBound" AutoGenerateColumns="False" PagerSettings-FirstPageText="First" PagerSettings-LastPageText="Last" PagerStyle-BackColor="#FFCCCC" AllowSorting="True" OnPageIndexChanging="grdComplaints_PageIndexChanging" OnRowCreated="grdComplaints_RowCreated" OnSorting="grdComplaints_Sorting">
        <AlternatingRowStyle BackColor="#F2DEDE" />
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="ckbSelectGrievance" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="GrievanceID" HeaderText="Complaint ID" SortExpression="GrievanceID" >
            <HeaderStyle Height="20px" VerticalAlign="Middle" Width="12%" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="GrievanceType" HeaderText="Complaint Type" SortExpression="GrievanceType" >
            <HeaderStyle Width="11%" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="GrievanceDescription" HeaderText="Complaint Description" SortExpression="GrievanceDescription" >
            <HeaderStyle Width="17%" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="DateLogged" HeaderText="Date of Logging" SortExpression="DateLogged" >
            <HeaderStyle Width="15%" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="TargetCompletionDate" HeaderText="Target Completion Date" SortExpression="TargetCompletionDate" >
            <HeaderStyle Width="18%" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="ResolutionStatus" HeaderText="Status" SortExpression="ResolutionStatus" >
            <HeaderStyle Width="15%" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location">
                <HeaderStyle Width="25%" Wrap="False" />
            </asp:BoundField>
            <asp:ImageField DataImageUrlField="Picture"  HeaderText="Picture" NullDisplayText="No Image" ReadOnly="True" DataImageUrlFormatString="~/Content/Grievances/Images/{0}">
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
    <div id="modal-Complete" class="modal fade" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Confirmation</h4>
          </div>
          <div class="modal-body">
            <p>Are you sure you want to mark selected complaints as completed?</p>
          </div>
          <div class="modal-footer">
            <asp:Button ID="btnVerifiedConfirm" runat="server" CssClass="btn btn-primary" Text="Yes"  OnClick="btnVerified_Click"/>
              <div class="btn btn-danger" data-dismiss="modal">No</div>
          </div>
        </div>

      </div>
    </div>
      <div id="modal-Shoddy" class="modal fade" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Confirmation</h4>
          </div>
          <div class="modal-body">
            <p>Are you sure you are not satified with the implemented solution for this complaint?</p>
          </div>
          <div class="modal-footer">
            <asp:Button ID="btnShoddyConfirm" runat="server" CssClass="btn btn-primary" Text="Yes" OnClick="btnShoddyConfirm_Click"/>
              <div class="btn btn-danger" data-dismiss="modal">No</div>
          </div>
        </div>

      </div>
    </div>
      <div id="modal-Ignored" class="modal fade" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Confirmation</h4>
          </div>
          <div class="modal-body">
            <p>Are you sure you want to flag this grievance?</p>
          </div>
          <div class="modal-footer">
            <asp:Button ID="btnIgnoredConfirm" runat="server" CssClass="btn btn-primary" Text="Yes" OnClick="btnIgnoredConfirm_Click"/>
              <div class="btn btn-danger" data-dismiss="modal">No</div>
          </div>
        </div>

      </div>
    </div>
    <script type="text/javascript">
        function setButtonStatus(status) {
            switch (status) {
                case "Verified":
                    $("#btnVerified").removeClass("disabled");
                    $("#btnUnsatisfied").removeClass("disabled");
                    $("#btnIgnored").addClass("disabled");
                    break;
                case "Ignored":
                    $("#btnVerified").addClass("disabled");
                    $("#btnUnsatisfied").addClass("disabled");
                    $("#btnIgnored").removeClass("disabled");
                    break;
                default:
                    $("#btnVerified").addClass("disabled");
                    $("#btnUnsatisfied").addClass("disabled");
                    $("#btnIgnored").addClass("disabled");
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
                    var enableverified = false;
                    var enableunsatisfied = false;
                    var enableignored = false;
                    var $grievanceTableRows = $("#<%=grdComplaints.ClientID%>").find("tr:gt(0)");
                    for (var i = 0; i < $grievanceTableRows.length; i++) {
                        if ($grievanceTableRows.find("td:eq(6)").text == "Created") {
                            enableignored = true;
                        }
                        else if ($grievanceTableRows.find("td:eq(6)").text == "Completed implementation") {
                            enableverified = true;
                        }
                    }
                    if (enableignored && enableverified) {
                        setButtonStatus("none");
                    }
                    else if (enableignored) {
                        setButtonStatus("Ignored");
                    }
                    else if (enableverified) {
                        setButtonStatus("Verified");
                    }
                }
                else {
                    $("#button-actions").addClass("hidden");
                }
            });

            $("#btnVerified").off("click").on("click", function () {
                $("#modal-Complete").modal("show");
            });
            $("#btnUnsatisfied").off("click").on("click", function () {
                $("#modal-Shoddy").modal("show");
            });
        });
    </script>
</asp:Content>


