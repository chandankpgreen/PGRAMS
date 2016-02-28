<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Complaints.aspx.cs" Inherits="ComplainantPortal_Complaints" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
     <h2>Log a Complaint</h2>
   
    <asp:PlaceHolder runat="server" ID="ErrorPlaceHolder" Visible="false">
        <div class="alert alert-danger">
            <asp:Literal runat="server" ID="ErrorMessage" />
        </div>
    </asp:PlaceHolder>
     
    <div class="form-horizontal">
        <hr />
         <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ddlComplaintType" CssClass="col-md-2 control-label">Complaint Type<span class="required-asterisk">*</span></asp:Label>
            <div class="col-md-10">
                <asp:DropDownList runat="server" ID="ddlComplaintType" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlComplaintType" Display="Dynamic"
                    CssClass="text-danger" ErrorMessage="Complaint Type is required." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtComplaintDescription" CssClass="col-md-2 control-label">Complaint Description<span class="required-asterisk">*</span></asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="txtComplaintDescription" CssClass="form-control" TextMode="MultiLine" Rows="7" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtComplaintDescription" Display="Dynamic"
                    CssClass="text-danger" ErrorMessage="Complaint description is required." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtComments" CssClass="col-md-2 control-label">Comments</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="txtComments" CssClass="form-control" TextMode="MultiLine" Rows="7" />
            </div>
        </div>
         <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="fuComplaintPic" CssClass="col-md-2 control-label">Problem area Picure(Optional)</asp:Label>
            <div class="col-md-10">
                <asp:FileUpload ID="fuComplaintPic" runat="server" />
            </div>
        </div>
       
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
              <div class="btn btn-success" id="btnRegisterConfirm">Log Complaint</div>
            </div>
        </div>
    </div>
        <!-- Modal -->
    <div id="modal-Log" class="modal fade" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Confirmation</h4>
          </div>
          <div class="modal-body">
            <p>Are you sure you have filled up all the required information before logging this complaint?</p>
          </div>
          <div class="modal-footer">
            <asp:Button ID="btnRegisterComplaint" class="btn btn-primary" runat="server" Text="Register Complaint" OnClick="btnRegisterComplaint_Click" OnClientClick="hideModal()"  />
              <div class="btn btn-danger" data-dismiss="modal">Wait, Let me check once.</div>
          </div>
        </div>

      </div>
    </div>
    <script type="text/javascript">
        function hideModal() {
            $("#modal-Log").modal("hide");
        }
        $(document).ready(function () {
            $("#btnRegisterConfirm").off("click").on("click", function () {
                $("#modal-Log").modal("show");
            });
        });
    </script>
</asp:Content>

