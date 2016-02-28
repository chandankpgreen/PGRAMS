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
    <div id="button-actions" style="margin-bottom:20px;margin-top:20px" class="hidden">
        <div ID="btnVerified" class="btn btn-success" title="Mark this complaint as resolved .Make sure that you are satisfied with the quality and timeliness of the job completed before clicking this.">Done! Thank You</div>
        <div ID="btnUnsatisfied"  class="btn btn-warning" title="Click this if you think the complaint was not resolved in a satisfactory way." >Shoddy Work, Not Satisfied</div>
        <div ID="btnIgnored"  class="btn btn-danger" title="Click this if you think the redressal department failed to take notice of this in time.">Did not start on time/Ignored</div>
    </div>
    <h4>Your Grievances Listed:</h4>
    <asp:GridView ID="grdComplaints" runat="server" BackColor="#FCF8E3" CellPadding="5" AllowPaging="True" EmptyDataText="No Complaints logged by you!" Font-Names="Open Sans,Segoe UI" PageSize="20" CssClass="grid-grievances" Width="100%" OnRowDataBound="grdComplaints_RowDataBound">
        <AlternatingRowStyle BackColor="#F2DEDE" />
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="ckbSelectGrievance" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <HeaderStyle BackColor="#337AB7" ForeColor="White" />
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

            $("#btnVerified").off("click").on("click", function () {
                $("#modal-Complete").modal("show");
            });
        });
    </script>
</asp:Content>


