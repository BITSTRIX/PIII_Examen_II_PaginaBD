<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Menu.Master" AutoEventWireup="true" CodeBehind="Inicio.aspx.cs" Inherits="PIII_Examen_II_PaginaBD.pages.Inicio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../css/StyleHome.css" rel="stylesheet" />
    <div>
        <svg>
            <text x="50%" y="50%" dy=".35em" text-anchor="middle">
			BIENVENIDO AL SISTEMA
		</text>
        </svg>
    </div>
    <div class ="Creditos">
        <text>Desarrollado por: </text>
        <br />
        <text>Jose Antonio Valerio Chaves</text>
        <br />
        <text>Programacion III</text>
    </div>
</asp:Content>
