<%@ Page Title="Equipos" Language="C#" MasterPageFile="~/Menu.Master" AutoEventWireup="true" CodeBehind="Equipos.aspx.cs" Inherits="PIII_Examen_II_PaginaBD.pages.Equipos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">

        .auto-style3 {
            height: 16px;
            text-align: left;
        }
        .auto-style5 {
            height: 16px;
            color: #FFFFFF;
            text-align: left;
        }

        .auto-style6 {
            padding: 3em;
            height: 174px;
            margin: 0 auto;
        }

        .auto-style7 {
            text-align: left;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../css/bootstrap.css" rel="stylesheet" />
    <link href="../css/Style.css" rel="stylesheet" />
    <div class="Formulario">
        <h1>CONTROL DE EQUIPOS</h1>
    <div class= "GridView">
        <asp:GridView ID="datagrid" class="myGridClass" runat="server"></asp:GridView>
    </div>
        <br />
        <br />

        <div class="Datos">
            <table class="auto-style6" align="center" >
                <tr>
                    <td class="auto-style5"><strong>ID del Equipo:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </strong> </td>
                    <td class="auto-style3">
                        <asp:TextBox ID="txtIdEquipo" runat="server" Height="30px" TextMode="Number" Width="249px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
    <td class="auto-style5"><strong>Tipo del Equipo:  </strong> </td>
    <td class="auto-style3">
        <asp:TextBox ID="txtTipoEquipo" runat="server" Height="30px" Width="249px"></asp:TextBox>
                    </td>
</tr>
                <tr>
                    <td class="auto-style5"><strong>Modelo del Equipo:</strong> </td>
                    <td class="auto-style3">
                        <asp:TextBox ID="txtModeloEquipo" runat="server" Height="30px" Width="249px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style5"><strong>Usuario del Equipo: </strong> </td>
                    <td class="auto-style7">
                        <asp:DropDownList ID="DropListUsuarioEquipo" runat="server" Height="30px" TextMode="Number" Width="249px">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </div>
        <div class="Buttons">
            <br />
            <br />
            <asp:Button ID="btnAgregar" class="btn btn-primary" runat="server" Text="Agregar" OnClick="btnAgregar_Click" style="margin: 4px"/>
            <asp:Button ID="btnConsultar" class="btn btn-info" runat="server" Text="Consultar" OnClick="btnConsultar_Click" style="margin: 4px"/>
             <asp:Button ID="btnModificar" class="btn btn-warning" runat="server" Text="Modificar" OnClick="btnModificar_Click" style="margin: 4px"/>
            <asp:Button ID="btnEliminar" class="btn btn-danger" runat="server" Text="Eliminar" OnClick="btnEliminar_Click" style="margin: 4px"/>
            <br />
            <br />
        </div>
</div>
</asp:Content>

