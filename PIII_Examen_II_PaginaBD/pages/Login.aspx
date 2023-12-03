<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PIII_Examen_II_PaginaBD.pages.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="../css/Login.css" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">
        <div class="Ingresar">
            <div class="imgcontainer">

                <img src="../images/hacker.png" alt="Avatar" class="avatar">
            </div>

            <div class="container">
                <label for="uname"><b>Correo Electrinico:</b></label>
                <asp:TextBox ID="txtCorreo" runat="server" placeholder="Ingrese su correo" required name="uname"></asp:TextBox>

                <label for="psw"><b>Contraseña: </b></label>
                <asp:TextBox ID="txtContrasenna" runat="server" type="password" placeholder="Ingrese su contraseña" required name="psw"></asp:TextBox>
                <asp:Button ID="submit" runat="server" Text="Ingresar" CssClass="ASPButton" OnClick="submit_Click" />
                <label>
                    <input type="checkbox" checked="checked" name="remember">
                    Recordar mi usuario
                </label>
            </div>

            <div class="container" style="background-color: #f1f1f1">
                <button type="button" onclick="document.getElementById('id02').style.display='none'" class="cancelbtn">Cancelar</button>
                <span class="psw">Olvidé mi <a href="#">contraseña?</a></span>
            </div>
        </div>

        <%--        <div class="Registrar">
            <button onclick="document.getElementById('id02').style.display='block'" style="width: auto;">Sign Up</button>

            <div id="id02" class="modal">
                <span onclick="document.getElementById('id02').style.display='none'" class="close" title="Close Modal">&times;</span>
                <form class="modal-content" action="/action_page.php">
                    <div class="container">
                        <h1>Sign Up</h1>
                        <p>Please fill in this form to create an account.</p>
                        <hr>
                        <label for="email"><b>Email</b></label>
                        <input type="text" placeholder="Enter Email" name="email" required>

                        <label for="psw"><b>Password</b></label>
                        <input type="password" placeholder="Enter Password" name="psw" required>

                        <label for="psw-repeat"><b>Repeat Password</b></label>
                        <input type="password" placeholder="Repeat Password" name="psw-repeat" required>

                        <label>
                            <input type="checkbox" checked="checked" name="remember" style="margin-bottom: 15px">
                            Remember me
                        </label>

                        <p>By creating an account you agree to our <a href="#" style="color: dodgerblue">Terms & Privacy</a>.</p>

                        <div class="clearfix">
                            <button type="button" onclick="document.getElementById('id02').style.display='none'" class="cancelbtn">Cancel</button>
                            <button type="submit" class="signupbtn">Sign Up</button>
                        </div>
                    </div>
                </form>
            </div>

            <script>
                // Get the modal
                var modal = document.getElementById('id02');

                // When the user clicks anywhere outside of the modal, close it
                window.onclick = function (event) {
                    if (event.target == modal) {
                        modal.style.display = "none";
                    }
                }
            </script>
        </div>--%>
    </form>
</body>
</html>
