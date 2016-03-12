<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Suggestions.aspx.cs" Inherits="ComplainantPortal_Suggestions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Have a Suggestion? Let us know</h2>

    <asp:PlaceHolder runat="server" ID="SuccessPlaceHolder" Visible="false">
        <div class="alert alert-success">
            <asp:Literal runat="server" ID="SuccessMessage" />
        </div>
    </asp:PlaceHolder>
    <hr />
    Your suggestions listed below :
     <div class="form-horizontal">
         <asp:Repeater ID="rptSuggestions" runat="server">
             <HeaderTemplate>
                 <table  cellpadding="5" cellspacing="10" style="width:70%;table-layout:fixed;border-radius:2px 2px;border: 1px solid #eeeeee">
                     <tr>
                         <th>Suggestion ID</th>
                         <th>Department</th>
                         <th style="width:40%">Description</th>
                         <th>Date</th>
                     </tr>
             </HeaderTemplate>

             <ItemTemplate>
                 <tr style="background-color:#FCF8E3">
                     <td><%# Eval("SuggestionID") %></td>
                     <td><%# Eval("Department") %></td>
                     <td><%# Eval("Description") %></td>
                     <td><%# Eval("DateLogged") %></td>
                 </tr>
             </ItemTemplate>
             <AlternatingItemTemplate>
                 <tr style="background-color:#F2DEDE">
                     <td><%# Eval("SuggestionID") %></td>
                     <td><%# Eval("Department") %></td>
                     <td><%# Eval("Description") %></td>
                     <td><%# Eval("DateLogged") %></td>
                 </tr>
             </AlternatingItemTemplate>
             <FooterTemplate>
                 </table>
             </FooterTemplate>

         </asp:Repeater>
     </div>
    <div class="form-horizontal">
        <hr />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ddlComplaintType" CssClass="col-md-2 control-label">Department<span class="required-asterisk">*</span></asp:Label>
            <div class="col-md-10">
                <asp:DropDownList runat="server" ID="ddlComplaintType" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlComplaintType" Display="Dynamic"
                    CssClass="text-danger" ErrorMessage="Department is required." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtComplaintDescription" CssClass="col-md-2 control-label">Suggestion Description<span class="required-asterisk">*</span></asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="txtComplaintDescription" CssClass="form-control" TextMode="MultiLine" Rows="7" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtComplaintDescription" Display="Dynamic"
                    CssClass="text-danger" ErrorMessage="Please enter the description" />
            </div>
        </div>

        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <div class="btn btn-success" id="btnRegisterConfirm">Send my Suggestion</div>
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
                    <p>Are you sure you want to send this suggestion across for the Administrator?</p>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnRegisterComplaint" class="btn btn-primary" runat="server" Text="Yes" OnClick="btnRegisterComplaint_Click" OnClientClick="hideModal()" />
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

