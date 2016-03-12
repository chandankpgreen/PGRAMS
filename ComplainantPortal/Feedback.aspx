<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Feedback.aspx.cs" Inherits="ComplainantPortal_Feedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
     <h2>Want to say on how we did? Share your feedback</h2>
   
    <asp:PlaceHolder runat="server" ID="SuccessPlaceHolder" Visible="false">
        <div class="alert alert-success">
            <asp:Literal runat="server" ID="SuccessMessage" />
        </div>
    </asp:PlaceHolder>
    <hr />
    Your feedbacks listed below :
     <div class="form-horizontal">
         <asp:Repeater ID="rptSuggestions" runat="server"></asp:Repeater>
    </div>
    <div class="form-horizontal">
        <hr />
         <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ddlComplaint" CssClass="col-md-2 control-label">Complaint<span class="required-asterisk">*</span></asp:Label>
            <div class="col-md-10">
                <asp:DropDownList runat="server" ID="ddlComplaint" CssClass="form-control" OnSelectedIndexChanged="ddlComplaint_SelectedIndexChanged" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlComplaint" Display="Dynamic"
                    CssClass="text-danger" ErrorMessage="Feedback must be linked to a Complaint." />
            </div>
            <div class="col-md-10">
                <asp:Literal ID="ltlComplaintDescription" runat="server"></asp:Literal>
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtComplaintDescription" CssClass="col-md-2 control-label">Feedback<span class="required-asterisk">*</span></asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="txtComplaintDescription" CssClass="form-control" TextMode="MultiLine" Rows="7" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtComplaintDescription" Display="Dynamic"
                    CssClass="text-danger" ErrorMessage="Please enter the feedback." />
            </div>
        </div>
       
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
              <div class="btn btn-success" id="btnRegisterConfirm">Send my Feedback</div>
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
            <p>Are you sure you want to send this Feedback?</p>
          </div>
          <div class="modal-footer">
              <asp:Button ID="btnRegisterFeedback" class="btn btn-primary" runat="server" Text="Yes" OnClientClick="hideModal()" OnClick="btnRegisterFeedback_Click" />
              <div class="btn btn-danger" data-dismiss="modal">No</div>
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

