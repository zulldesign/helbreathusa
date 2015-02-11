<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="Themes.aspx.cs" Inherits="Admin_Themes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <%: Styles.Render("~/Content/themes/base/css") %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <br /><asp:Literal ID="MessageLiteral" runat="server"></asp:Literal><br /><br />
    Select Theme to Install: <asp:DropDownList ID="InstalledThemesDropDownList" ClientIDMode="Static" runat="server">
    </asp:DropDownList><br /><br />
    <asp:Button ID="InstallButton" runat="server" Text="Change Store Theme" 
        onclick="InstallButton_Click" /><br /><br />
    <b><a href="http://www.shoppingcartnet.com" target="_blank">Get More Themes</a></b> 
    <br /><br />
    Upload a Theme file <input id="ThemeFile" type="file" /><a href="#" onclick="javascript:uploadTheme();">Upload</a><br />
    <div id="progressbar" style="width:200px;height:10px;"></div>
    <br /><br />
 
<script type="text/javascript">

    $(function () {
        document.getElementById('ThemeFile').addEventListener('change', handleFileSelect, false);
    });


    function handleFileSelect(evt) {
        var files = evt.target.files; // FileList object
        var control = $("#ThemeFile");
        // Make sure this is a zip file and that the theme doesnt exist.
        for (var i = 0, f; f = files[i]; i++) {
            if (f.name.split('.').pop().toLowerCase() != "zip") {
                alert('Please select a valid zip file');
                control.replaceWith(control = control.clone(true));
                document.getElementById('ThemeFile').addEventListener('change', handleFileSelect, false);
            }

            var installedThemes = document.getElementById('InstalledThemesDropDownList');
            for (var i = 0; i < installedThemes.length; i++) {
                if (installedThemes.options[i].text.toLowerCase() == f.name.substr(0, f.name.lastIndexOf('.')).toLowerCase())
                    if (!confirm("Theme already exists. Would you like to override it?")) {
                        control.replaceWith(control = control.clone(true));
                        document.getElementById('ThemeFile').addEventListener('change', handleFileSelect, false);
                    }
            }

        }
    }

    function uploadTheme() {
        if ($("#ThemeFile").val() == '') {
            alert('Please select a theme file');
            return false;
        }
        $("#progressbar").progressbar();
        var formData = new FormData();

        formData.append("imageFile", document.getElementById("ThemeFile").files[0]);
        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'ThemeUploadHandler.ashx', true);
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

