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
    public partial class Tecnicos : System.Web.UI.Page
    {
        ClaseTecnicos ClaseTecnicos = new ClaseTecnicos();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarTabla();
                LlenarDropListUsuariosSistema();
            }
        }

        protected void LlenarTabla()
        {
            string constr = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM Tecnicos"))
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

        protected void LlenarDropListUsuariosSistema()
        {
            string constr = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open(); // Abre la conexión antes de ejecutar el comando
                using (SqlCommand cmd = new SqlCommand("PcDropListUsuarioSistema", con)) // Llama al procedimiento almacenado
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            DropListUsuarioSistema.DataSource = dt;
                            DropListUsuarioSistema.DataValueField = "userID";
                            DropListUsuarioSistema.DataTextField = "nombre";
                            DropListUsuarioSistema.DataBind();
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

            if (txtNombre.Text != string.Empty)
            {
                int resultado = clases.ClaseTecnicos.AgregarTecnico(txtNombre.Text, txtEspecialidad.Text, int.Parse(DropListUsuarioSistema.SelectedValue));
                if (resultado > 0)
                {
                    Alertas("Tecnico registrado correctamente.");
                    Limpiar();
                }
                else
                {
                    Alertas("Error al ingresar el Tecnico.");
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
            txtIdTecnico.Text = string.Empty;
            txtNombre.Text = string.Empty;
            txtEspecialidad.Text = string.Empty;
            LlenarTabla();
            LlenarDropListUsuariosSistema();
        }



        protected void btnConsultar_Click(object sender, EventArgs e)
        {
            if (txtIdTecnico.Text != string.Empty)
            {
                List<ClaseTecnicos> Lista;
                Lista = (ClaseTecnicos.ConsultarTecnico(Convert.ToInt32(txtIdTecnico.Text)));

                if (Lista.Count == 0)
                {
                    Alertas("No se ha encontrando ningun registro en la Base de Datos.");
                    Limpiar();
                }
                else
                {
                    ClaseTecnicos DatoExtraido = Lista[0];
                    txtIdTecnico.Text = DatoExtraido.id.ToString();
                    txtNombre.Text = DatoExtraido.nombre.ToString();
                    txtEspecialidad.Text = DatoExtraido.especialidad.ToString();
                    DropListUsuarioSistema.SelectedValue = DatoExtraido.idSystem.ToString();
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
            if (txtIdTecnico.Text != string.Empty)
            {
                int resultado = clases.ClaseTecnicos.EliminarTecnico(Convert.ToInt32(txtIdTecnico.Text));
                if (resultado > 0)
                {
                    Alertas("Tecnico eliminado correctamente.");
                    Limpiar();
                }
                else
                {
                    Alertas("Error al intentar eliminar el Tecnico.");
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
            if (txtIdTecnico.Text != string.Empty && txtNombre.Text != string.Empty && txtEspecialidad.Text != string.Empty)
            {
                int resultado = clases.ClaseTecnicos.ModificarTecnico(Convert.ToInt32(txtIdTecnico.Text), txtNombre.Text, txtEspecialidad.Text, int.Parse(DropListUsuarioSistema.SelectedValue));
                if (resultado > 0)
                {
                    Alertas("Tecnico modificado correctamente.");
                    Limpiar();
                }
                else
                {
                    Alertas("Error al modificar el Tecnico.");
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