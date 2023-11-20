using PIII_Examen_II_PaginaBD.clases;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PIII_Examen_II_PaginaBD.clases;

namespace PIII_Examen_II_PaginaBD.pages
{
    public partial class Usuarios : System.Web.UI.Page
    {
        ClaseUsuarios ClaseUsuarios = new ClaseUsuarios();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarTabla();
            }

        }
        protected void LlenarTabla()
        {
            string constr = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM Usuarios"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            datagrid.DataSource = dt;
                            datagrid.DataBind(); //Este comando refresca los datos.
                        }
                    }

                }
            }
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

        protected void btnAgregar_Click(object sender, EventArgs e)
        {

            if (txtNombre.Text != string.Empty && txtTelefono.Text != string.Empty)
            {
                int resultado = clases.ClaseUsuarios.AgregarUsuario(txtNombre.Text, txtCorreo.Text, txtTelefono.Text);
                if (resultado > 0)
                {
                    Alertas("Usuario registrado correctamente.");
                    Limpiar();
                }
                else
                {
                    Alertas("Error al ingresar el Usuario.");
                }
            }
            else
            {
                string script = "alert('Error: Los datos no fueron ingresados correctamente.');";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta", script, true);
            }
        }

        public void Limpiar()
        {
            txtIdUsuario.Text = string.Empty;
            txtNombre.Text = string.Empty;
            txtCorreo.Text = string.Empty;
            txtTelefono.Text = string.Empty;
            LlenarTabla();
        }



        protected void btnConsultar_Click(object sender, EventArgs e)
        {
            if (txtIdUsuario.Text != string.Empty)
            {
                List<ClaseUsuarios> Lista;
                Lista = (ClaseUsuarios.ConsultarUsuario(Convert.ToInt32(txtIdUsuario.Text)));

                if (Lista.Count == 0)
                {
                    Alertas("No se ha encontrando ningun registro en la Base de Datos.");
                    Limpiar();
                }
                else
                {
                    ClaseUsuarios DatoExtraido = Lista[0];
                    txtIdUsuario.Text = DatoExtraido.id.ToString();
                    txtNombre.Text = DatoExtraido.nombre.ToString();
                    txtCorreo.Text = DatoExtraido.correo.ToString();
                    txtTelefono.Text = DatoExtraido.telefono.ToString();
                }
            }
            else
            {
                string script = "alert('Error: Consulta Invalida.');";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta", script, true);
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            if (txtIdUsuario.Text != string.Empty)
            {
                int resultado = clases.ClaseUsuarios.EliminarUsuario(Convert.ToInt32(txtIdUsuario.Text));
                if (resultado > 0)
                {
                    Alertas("Usuario eliminado correctamente.");
                    Limpiar();
                }
                else
                {
                    Alertas("Error al intentar eliminar el Usuario.");
                }
            }
            else
            {
                string script = "alert('Error: ID del registro invalido.');";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta", script, true);
            }
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            if (txtIdUsuario.Text != string.Empty && txtNombre.Text != string.Empty && txtTelefono.Text != string.Empty)
            {
                int resultado = clases.ClaseUsuarios.ModificarUsuario(Convert.ToInt32(txtIdUsuario.Text), txtNombre.Text, txtCorreo.Text, txtTelefono.Text);
                if (resultado > 0)
                {
                    Alertas("Usuario modificado correctamente.");
                    Limpiar();
                }
                else
                {
                    Alertas("Error al modificar el Usuario.");
                }
            }
            else
            {
                string script = "alert('Error: Los datos no fueron ingresados correctamente.');";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta", script, true);
            }
        }
    }
}