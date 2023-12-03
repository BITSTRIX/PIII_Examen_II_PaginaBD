using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PIII_Examen_II_PaginaBD.pages
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void Alertas(String texto)
        {
            string message = texto;
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.onload=function(){");
            sb.Append("alert('");
            sb.Append(message);
            sb.Append("')};");
            sb.Append("</script>");
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            clases.ClaseInicioSesion objUsuario = new clases.ClaseInicioSesion(txtContrasenna.Text, txtCorreo.Text);
            if (clases.ClaseInicioSesion.ValidarLogin() > 0)
            {
                Response.Redirect("../pages/Inicio.aspx");
            }
            else
            {
                Alertas("Usuario Invalido.");
            }
        }
    }
}