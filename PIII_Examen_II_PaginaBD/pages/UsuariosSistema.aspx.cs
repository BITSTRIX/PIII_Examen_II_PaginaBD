﻿using PIII_Examen_II_PaginaBD.clases;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PIII_Examen_II_PaginaBD.pages
{
    public partial class UsuariosSistema : System.Web.UI.Page
    {
        ClaseUsuarioSistema ClaseUsuarioSistema = new ClaseUsuarioSistema();
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
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM systemUsers"))
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
                int resultado = clases.ClaseUsuarioSistema.AgregarUsuarioSistema(txtNombre.Text, txtCorreo.Text, txtTelefono.Text, txtPassword.Text);
                if (resultado > 0)
                {
                    Alertas("Empleado registrado correctamente.");
                    Limpiar();
                }
                else
                {
                    Alertas("Error al ingresar el Empleado.");
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
                List<ClaseUsuarioSistema> Lista;
                Lista = (ClaseUsuarioSistema.ConsultarUsuarioSistema(Convert.ToInt32(txtIdUsuario.Text)));

                if (Lista.Count == 0)
                {
                    Alertas("No se ha encontrando ningun registro en la Base de Datos.");
                    Limpiar();
                }
                else
                {
                    ClaseUsuarioSistema DatoExtraido = Lista[0];
                    txtIdUsuario.Text = DatoExtraido.id.ToString();
                    txtNombre.Text = DatoExtraido.nombre.ToString();
                    txtCorreo.Text = DatoExtraido.correo.ToString();
                    txtTelefono.Text = DatoExtraido.telefono.ToString();
                    txtPassword.Text = DatoExtraido.password.ToString();
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
                int resultado = clases.ClaseUsuarioSistema.EliminarUsuarioSistema(Convert.ToInt32(txtIdUsuario.Text));
                if (resultado > 0)
                {
                    Alertas("Empleado eliminado correctamente.");
                    Limpiar();
                }
                else
                {
                    Alertas("Error al intentar eliminar el Empleado.");
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
                int resultado = clases.ClaseUsuarioSistema.ModificarUsuarioSistema(Convert.ToInt32(txtIdUsuario.Text), txtNombre.Text, txtCorreo.Text, txtTelefono.Text, txtPassword.Text);
                if (resultado > 0)
                {
                    Alertas("Empleado modificado correctamente.");
                    Limpiar();
                }
                else
                {
                    Alertas("Error al modificar el Empleado.");
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