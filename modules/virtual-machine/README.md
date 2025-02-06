<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_harvester"></a> [harvester](#requirement\_harvester) | 0.6.4 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.5.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_harvester"></a> [harvester](#provider\_harvester) | 0.6.4 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [harvester_virtualmachine.vm](https://registry.terraform.io/providers/harvester/harvester/0.6.4/docs/resources/virtualmachine) | resource |
| [null_resource.connection_test](https://registry.terraform.io/providers/hashicorp/null/3.2.2/docs/resources/resource) | resource |
| [harvester_image.vm_image](https://registry.terraform.io/providers/harvester/harvester/0.6.4/docs/data-sources/image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_disks"></a> [additional\_disks](#input\_additional\_disks) | n/a | <pre>map(object({<br/>    name  = string<br/>    mount = string<br/>    size  = string<br/>  }))</pre> | n/a | yes |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | n/a | `number` | `2` | no |
| <a name="input_efi_boot"></a> [efi\_boot](#input\_efi\_boot) | n/a | `bool` | n/a | yes |
| <a name="input_enable_dhcp"></a> [enable\_dhcp](#input\_enable\_dhcp) | n/a | `bool` | `false` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | n/a | `string` | `"16Gi"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the vm | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Name of the namespace into which the VMs with be delployed. It must exist | `string` | n/a | yes |
| <a name="input_networks"></a> [networks](#input\_networks) | Map of harvester VM networks to add NICs for | <pre>map(object({<br/>    ip      = string<br/>    cidr    = number<br/>    gateway = string<br/>    dns     = string<br/>    network = string<br/>    iface   = string<br/>  }))</pre> | n/a | yes |
| <a name="input_root_disk_size"></a> [root\_disk\_size](#input\_root\_disk\_size) | n/a | `string` | `"30Gi"` | no |
| <a name="input_run_strategy"></a> [run\_strategy](#input\_run\_strategy) | n/a | `string` | `"RerunOnFailure"` | no |
| <a name="input_ssh_private_key"></a> [ssh\_private\_key](#input\_ssh\_private\_key) | n/a | `string` | n/a | yes |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Data for cloud-init to use | `string` | n/a | yes |
| <a name="input_vm_image"></a> [vm\_image](#input\_vm\_image) | OS image to use | `string` | `"rhel-9.3"` | no |
| <a name="input_vm_image_namespace"></a> [vm\_image\_namespace](#input\_vm\_image\_namespace) | OS image namespace to use | `string` | `""` | no |
| <a name="input_vm_username"></a> [vm\_username](#input\_vm\_username) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
