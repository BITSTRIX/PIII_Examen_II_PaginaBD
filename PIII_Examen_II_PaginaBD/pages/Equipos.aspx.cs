using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PIII_Examen_II_PaginaBD.clases;

namespace PIII_Examen_II_PaginaBD.pages
{

    public partial class Equipos : System.Web.UI.Page
    {
        ClaseEquipos ClaseEquipos = new ClaseEquipos();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                LlenarTabla();
                LlenarDropListUsuarios();
            }
            
        }

        public static class GVar
        {
            public static int indexSelected = 0;
        }

        protected void LlenarTabla()
        {
            string constr = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM Equipos"))
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

        //Ctrl + K + C – manteniendo la tecla Ctrl presionada todo el tiempo.
        //Ctrl + K + U – manteniendo la tecla Ctrl presionada todo el tiempo.

        protected void LlenarDropListUsuarios()
        {
            string constr = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT usuarioID, nombre FROM Usuarios"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            DropListUsuarioEquipo.DataSource = dt;
                            DropListUsuarioEquipo.DataValueField = dt.Columns["usuarioID"].ToString();
                            DropListUsuarioEquipo.DataTextField = dt.Columns["nombre"].ToString();
                            DropListUsuarioEquipo.DataBind(); //Este comando refresca los datos.
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

            if (txtTipoEquipo.Text != string.Empty && DropListUsuarioEquipo.Text != string.Empty)
            {
                int resultado = clases.ClaseEquipos.AgregarEquipo(txtTipoEquipo.Text, txtModeloEquipo.Text, int.Parse(DropListUsuarioEquipo.SelectedValue));
                if (resultado > 0)
                {
                    Alertas("Equipo registrado correctamente.");
                    Limpiar();
                }
                else
                {
                    Alertas("Error al ingresar el equipo.");
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
            txtIdEquipo.Text = string.Empty;
            txtModeloEquipo.Text = string.Empty;
            txtTipoEquipo.Text = string.Empty;
            DropListUsuarioEquipo.SelectedValue = null;
            LlenarTabla();
            LlenarDropListUsuarios();
        }



        protected void btnConsultar_Click(object sender, EventArgs e)
        {
            if (txtIdEquipo.Text != string.Empty)
            {
                List<ClaseEquipos> Lista;
                Lista = (ClaseEquipos.ConsultarEquipo(Convert.ToInt32(txtIdEquipo.Text)));

                if (Lista.Count == 0)
                {
                    Alertas("No se ha encontrando ningun registro en la Base de Datos.");
                    Limpiar();
                }
                else
                {
                    ClaseEquipos DatoExtraido = Lista[0];
                    txtIdEquipo.Text = DatoExtraido.id.ToString();
                    txtTipoEquipo.Text = DatoExtraido.tipoEquipo.ToString();
                    txtModeloEquipo.Text = DatoExtraido.modelo.ToString();
                    DropListUsuarioEquipo.Text = DatoExtraido.usuarioID.ToString();
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

            if (txtIdEquipo.Text != string.Empty)
            {
                int resultado = clases.ClaseEquipos.EliminarEquipo(Convert.ToInt32(txtIdEquipo.Text));
                if (resultado > 0)
                {
                    Alertas("Equipo eliminado correctamente.");
                    Limpiar();
                }
                else
                {
                    Alertas("Error al intentar eliminar el equipo.");
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
            if (txtIdEquipo.Text != string.Empty && txtTipoEquipo.Text != string.Empty && DropListUsuarioEquipo.Text != string.Empty)
            {
                int resultado = clases.ClaseEquipos.ModificarEquipo(Convert.ToInt32(txtIdEquipo.Text), txtTipoEquipo.Text, txtModeloEquipo.Text, int.Parse(DropListUsuarioEquipo.SelectedValue));
                if (resultado > 0)
                {
                    Alertas("Equipo modificado correctamente.");
                    Limpiar();
                }
                else
                {
                    Alertas("Error al modificar el equipo.");
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