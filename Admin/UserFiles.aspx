<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="UserFiles.aspx.cs" Inherits="Admin_UserFiles" %>
<%@ Import Namespace="InvertedSoftware.ShoppingCart.Common" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <%: Styles.Render("~/Content/themes/base/css") %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <asp:Literal ID="MessageLiteral" runat="server"></asp:Literal><br />
    Upload files <input id="UploadFile" type="file" multiple /><a href="#" onclick="javascript:uploadFiles();">Upload</a><br />
    <div id="progressbar" style="width:200px;height:10px;"></div>
    <br /><br />
    Total Files: <%: TotalFiles%> (size: <%: DirectorySize / 1024 %> KB)<br /><br />
    <asp:GridView ID="UserFilesGridView" SelectMethod="UserFilesGridView_GetData" AutoGenerateColumns="False" ItemType="System.IO.FileInfo" DataKeyNames="Name" DeleteMethod="UserFilesGridView_DeleteItem" runat="server" AllowPaging="True" PageSize="20" OnRowDataBound="UserFilesGridView_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="Name">
                <ItemTemplate><%# Container.DataItem %></ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Link">
                <ItemTemplate>
                   <%: ResolveUrl("~/UserFiles/") %><%# Container.DataItem %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowDeleteButton="True" />
        </Columns>
    </asp:GridView>
    <br /><br />
    <script type="text/javascript">
        function uploadFiles() {
            if ($("#UploadFile").val() == '') {
                alert('Please select files to upload');
                return false;
            }
            $("#progressbar").progressbar();
            var formData = new FormData();
            for (var i = 0; i < document.getElementById("UploadFile").files.length; i++) {
                formData.append("userFiles" + i, document.getElementById("UploadFile").files[i]);
            }
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'FilesUploadHandler.ashx', true);
            xhr.upload.onprogress = function (e) {
                if (e.lengthComputable) {
                    var percentComplete = (e.loaded / e.total) * 100;
                    $("#progressbar").progressbar({ value: percentComplete });
                }
            };
            xhr.onload = function () {
                if (this.status == 200 && this.responseText == 'OK') {
                    $("#progressbar").progressbar("destroy");
                    location.reload(true);
                }
                else {
                    alert(this.responseText);
                }
            };
            xhr.onerror = function () {
                alert('error');
            };
            xhr.send(formData);
        }
</script>

</asp:Content>

