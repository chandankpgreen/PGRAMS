<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Complaints.aspx.cs" Inherits="ComplainantPortal_Complaints" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
     <h2>Log a Complaint</h2>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

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
                <asp:TextBox runat="server" ID="txtComplaintDescription" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ComplaintDescription" Display="Dynamic"
                    CssClass="text-danger" ErrorMessage="Complaint description is required." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtComments" CssClass="col-md-2 control-label">Comments</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="txtComments" CssClass="form-control" />
            </div>
        </div>
         <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ComplaintPic" CssClass="col-md-2 control-label">Problem area Picure(Optional)</asp:Label>
            <div class="col-md-10">
                <asp:FileUpload ID="fuComplaintPic" runat="server" />
            </div>
        </div>
       
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button ID="btnRegisterComplaint" runat="server" Text="Register Complaint" CssClass="btn btn-default" OnClick="btnRegisterComplaint_Click"  />
            </div>
        </div>
    </div>
</asp:Content>

