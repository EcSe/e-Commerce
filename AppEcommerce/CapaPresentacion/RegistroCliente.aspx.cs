using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


using CapaNegocio;
using CapaEntidades;

public partial class RegistroCliente : System.Web.UI.Page
{
    PaisBL pais = new PaisBL();
    ClienteEntidad cli = new ClienteEntidad();

    ServiceReferenceCliente.ServiceClienteClient service = new ServiceReferenceCliente.ServiceClienteClient();
   
   

    protected void Page_Load(object sender, EventArgs e)
    {
        mostrarPaises();
    

    }
    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        PaisEntidad pais = new PaisEntidad();
        cli.pais = pais;
       

        cli.Nombres = txtNombre.Text;
        cli.Apellidos = txtApellido.Text;
        cli.Sexo = dropSexo.SelectedValue;
        cli.TipoDocumento = dropTipoDocumento.SelectedValue;
        cli.NroDocumento = txtNroDocumento.Text;
        cli.Email = txtEmail.Text;
        cli.Provincia = txtProvincia.Text;
        cli.Ciudad = txtCiudad.Text;
        cli.Distrito = txtDistrito.Text;
        cli.Direccion = txtDireccion.Text;
        cli.Usuario = txtUsuario.Text;
        cli.Contrasena = txtContrasena.Text;
        cli.RazonSocial = txtRazonSocial.Text;
        cli.RUC = txtRUC.Text;
        cli.FechaNac = Convert.ToDateTime(txtFechaNac.Text);
        cli.EstadoCivil = dropEstadoCivil.SelectedValue;
        cli.Ocupacion = txtOcupacion.Text;
        cli.Telefono = txtTelefono.Text;
        pais.CodPais = dropPais.SelectedValue;

        string mensaje = service.Agregar(cli).Last();
    }

    public void mostrarPaises()
    {
        dropPais.DataSource = pais.Listar().Tables[0].DefaultView;
        dropPais.DataValueField = "CodPais";
        dropPais.DataTextField = "Nombre";
        dropPais.DataBind();
    }
}