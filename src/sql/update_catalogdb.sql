delete from service_recipe;
delete from heat_environment;
delete from heat_template_params;
delete from heat_template;
delete from VNF_RES_CUSTOM_TO_VF_MODULE_CUSTOM;
delete from  VF_MODULE_CUSTOMIZATION;
delete from vf_module;
delete from VNF_RESOURCE_CUSTOMIZATION;
delete from vnf_resource;
delete from SERVICE_TO_RESOURCE_CUSTOMIZATIONS;
delete from service;

-- For VduPlugin
INSERT INTO SERVICE(MODEL_UUID, MODEL_NAME, MODEL_VERSION, DESCRIPTION, TOSCA_CSAR_ARTIFACT_UUID, CREATION_TIMESTAMP, MODEL_INVARIANT_UUID, SERVICE_TYPE, SERVICE_ROLE, ENVIRONMENT_CONTEXT, WORKLOAD_CONTEXT) VALUES
('3b50d3d0-cd00-4878-a42f-3912763181ba','CLOUDIFY_POC','7.0','Cloudify POC Service',NULL,'2017-02-03 17:13:43','7b0fafc1-83df-4590-9460-b5a8d9f9f277',NULL,NULL,NULL,NULL);

-- For VduPlugin
INSERT INTO SERVICE_TO_RESOURCE_CUSTOMIZATIONS(MODEL_TYPE, RESOURCE_MODEL_CUSTOMIZATION_UUID, CREATION_TIMESTAMP, SERVICE_MODEL_UUID) VALUES
('vnf','d1fd6760-529f-4cce-ac22-55f59a96067e','2017-10-16 12:00:00','3b50d3d0-cd00-4878-a42f-3912763181ba'),
('vnf','da86dd87-43c5-458c-b226-5315b7be9ad5','2017-05-26 15:08:25','3b50d3d0-cd00-4878-a42f-3912763181ba');

-- For VduPlugin
INSERT INTO VNF_RESOURCE(MODEL_UUID, MODEL_INVARIANT_UUID, MODEL_VERSION, MODEL_NAME, TOSCA_NODE_TYPE, DESCRIPTION, ORCHESTRATION_MODE, AIC_VERSION_MIN, AIC_VERSION_MAX, HEAT_TEMPLATE_ARTIFACT_UUID, CREATION_TIMESTAMP) VALUES
('1669b580-f443-48fa-a163-f0aba3198f6f','7a106f01-c535-4c0b-9ebf-d568dbe62aa0','1.0','HeatTest',NULL,'Test VNF with modules for Heat','HEAT',NULL,NULL,NULL,'2017-10-16 12:00:00'),
('7097d8bb-f6ad-4cf7-866e-6a04c8f1b332','6ea0b528-e303-4686-aa77-aa2fcbdccb96','2.0','CloudifyTest',NULL,'Test VNF with modules for Cloudify POC','CLOUDIFY',NULL,NULL,NULL,'2017-02-08 16:53:24');

-- For VduPlugin
INSERT INTO VNF_RESOURCE_CUSTOMIZATION(MODEL_CUSTOMIZATION_UUID, MODEL_INSTANCE_NAME, MIN_INSTANCES, MAX_INSTANCES, AVAILABILITY_ZONE_MAX_COUNT, NF_FUNCTION, NF_TYPE, NF_ROLE, NF_NAMING_CODE, MULTI_STAGE_DESIGN, VNF_RESOURCE_MODEL_UUID, CREATION_TIMESTAMP) VALUES
('d1fd6760-529f-4cce-ac22-55f59a96067e','heat_test_vnf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1669b580-f443-48fa-a163-f0aba3198f6f','2017-10-16 12:00:00'),
('da86dd87-43c5-458c-b226-5315b7be9ad5','cloudify_test_vnf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'7097d8bb-f6ad-4cf7-866e-6a04c8f1b332','2017-05-26 15:08:24');

-- For VduPlugin
INSERT INTO VF_MODULE(MODEL_UUID, VNF_RESOURCE_MODEL_UUID, MODEL_INVARIANT_UUID, MODEL_VERSION, MODEL_NAME, DESCRIPTION, IS_BASE, HEAT_TEMPLATE_ARTIFACT_UUID, VOL_HEAT_TEMPLATE_ARTIFACT_UUID, CREATION_TIMESTAMP) VALUES
('cba2ef2e-3cb4-459c-a433-03705b59dc9b','1669b580-f443-48fa-a163-f0aba3198f6f','f057d9f4-6009-4d62-8711-967da1100071','1','HeatTest..onap_vnf_base..module-0',NULL,1,'021c2d81-7cbb-4c55-bcd9-49a4dc9eb2ab',NULL,'2017-10-16 12:00:00'),
('cba88123-3cb4-459c-a433-03705b59dc9b','1669b580-f443-48fa-a163-f0aba3198f6f','f05aa1b3-6009-4d62-8711-967da1100071','1','HeatTest..onap_vnf_addon..module-0',NULL,0,'02188ab2-7cbb-4c55-bcd9-49a4dc9eb2ab',NULL,'2017-10-16 12:00:00'),
('ebc48e21-3e62-4c24-bcd6-961e98701a0a','7097d8bb-f6ad-4cf7-866e-6a04c8f1b332','f5655432-ec71-4916-bf3b-93a654efcba4','1','CloudifyTest..onap_vnf_base..module-0',NULL,1,'e1588523-0087-4502-8779-0f3f94eef13c',NULL,'2017-02-08 16:53:24'),
('ebc5a111-3e62-4c24-bcd6-961e98701a0a','7097d8bb-f6ad-4cf7-866e-6a04c8f1b332','f56980a1-ec71-4916-bf3b-93a654efcba4','1','CloudifyTest..onap_vnf_addon..module-0',NULL,0,'e15ab762-0087-4502-8779-0f3f94eef13b',NULL,'2017-02-08 16:53:24');

-- For VduPlugin
INSERT INTO VF_MODULE_CUSTOMIZATION(MODEL_CUSTOMIZATION_UUID, VF_MODULE_MODEL_UUID, VOL_ENVIRONMENT_ARTIFACT_UUID, CREATION_TIMESTAMP, HEAT_ENVIRONMENT_ARTIFACT_UUID, MIN_INSTANCES, MAX_INSTANCES, INITIAL_COUNT, AVAILABILITY_ZONE_COUNT, LABEL) VALUES
('17424b51-742e-40f5-b9c8-83918849a787','ebc48e21-3e62-4c24-bcd6-961e98701a0a',NULL,'2017-05-26 15:08:23','ff526790-2b31-4b0f-aa29-06d5e198cc42',1,1,1,NULL,'onap_vnf_base'),
('17448001-742e-40f5-b9c8-83918849a787','ebc5a111-3e62-4c24-bcd6-961e98701a0a',NULL,'2017-05-26 15:08:23','ff530087-2b31-4b0f-aa29-06d5e198cc42',1,1,1,NULL,'onap_vnf_addon'),
('1c747ccc-f243-4893-8cf4-47c5f52c445c','cba2ef2e-3cb4-459c-a433-03705b59dc9b',NULL,'2017-10-16 12:00:00','0b188fb6-d0e5-4599-ad87-fc4e3a246ddf',1,1,1,NULL,'heat_vnf_base'),
('1c7901ae-f243-4893-8cf4-47c5f52c445c','cba88123-3cb4-459c-a433-03705b59dc9b',NULL,'2017-10-16 12:00:00','0b198ff1-d0e5-4599-ad87-fc4e3a246ddf',1,1,1,NULL,'heat_vnf_addon');

-- For VduPlugin
INSERT INTO VNF_RES_CUSTOM_TO_VF_MODULE_CUSTOM(VNF_RESOURCE_CUST_MODEL_CUSTOMIZATION_UUID, VF_MODULE_CUST_MODEL_CUSTOMIZATION_UUID, CREATION_TIMESTAMP) VALUES
('d1fd6760-529f-4cce-ac22-55f59a96067e','1c747ccc-f243-4893-8cf4-47c5f52c445c','2017-10-16 12:00:00'),
('da86dd87-43c5-458c-b226-5315b7be9ad5','1740536a-742e-40f5-b9c8-83918849a787','2017-05-26 15:08:24'),
('da86dd87-43c5-458c-b226-5315b7be9ad5','17424b51-742e-40f5-b9c8-83918849a787','2017-05-26 15:08:24'),
('da86dd87-43c5-458c-b226-5315b7be9ad5','17448001-742e-40f5-b9c8-83918849a787','2017-05-26 15:08:24');

-- For VduPlugin
INSERT INTO HEAT_TEMPLATE(ARTIFACT_UUID, NAME, VERSION, BODY, TIMEOUT_MINUTES, DESCRIPTION, CREATION_TIMESTAMP, ARTIFACT_CHECKSUM) VALUES
('02188ab2-7cbb-4c55-bcd9-49a4dc9eb2ab', 'heat_addon.yaml', '1', 'heat_template_version: 2015-04-30\n\ndescription:  Addon heat template for Heat/Cloudify test.  Creates one VM\n\nparameters:\n  image:\n    type: string\n    description: Openstack image name or id for the new server (from Env)\n  flavor:\n    type: string\n    description: Openstack flavor name or id for the new server (from Env)\n  vm_name:\n    type: string\n    description: Name for the new VM\n  network_name:\n    type: string\n    description: Openstack network name the new server will be connected to\n  secgroup_id:\n    type: string\n    description: Openstack security group ID (from Base)\n  keypair_name:\n    type: string\n    description: Openstack keypair Name (from Base)\n  \n\nresources:\n  vm:\n    type:  OS::Nova::Server\n    properties:\n      name:  {get_param:  vm_name}\n      image:  {get_param:  image}\n      flavor:  {get_param:  flavor}\n      networks:\n      - network: { get_param:  network_name }\n      security_groups: [ {get_param: secgroup_id} ]\n      key_name:  {get_param: keypair_name}\n', 3, 'HEAT addon template','2017-10-17 11:00:00','MANUAL_RECORD');
INSERT INTO HEAT_TEMPLATE(ARTIFACT_UUID, NAME, VERSION, BODY, TIMEOUT_MINUTES, DESCRIPTION, CREATION_TIMESTAMP, ARTIFACT_CHECKSUM) VALUES
('021c2d81-7cbb-4c55-bcd9-49a4dc9eb2ab', 'heat_base.yaml',  '1', 'heat_template_version: 2015-04-30\n\ndescription: Base Heat template for Heat/Cloudify test.  Describes a Security Group created using Heat\n\n\nparameters:\n  key_pair_name:\n    type: string\n    description: Keypair name for VMs\n\n  vnf_name:\n    type: string\n    description: VNF name\n\n\nresources:\n  security_group:\n    type: OS::Neutron::SecurityGroup\n    properties:\n      description: Security Group for VMs\n      name:\n        str_replace:\n          template: VNF_NAME_secgroup\n          params:\n            VNF_NAME: { get_param: vnf_name }\n      rules:\n        - {\"remote_ip_prefix\": \"0.0.0.0/0\", \"protocol\": \"tcp\", \"port_range_min\": 80, \"port_range_max\": 80}\n        - {\"remote_ip_prefix\": \"0.0.0.0/0\", \"protocol\": \"tcp\", \"port_range_min\": 22, \"port_range_max\": 22}\n\n\noutputs:\n  secgroup_id:\n    description: ID of the security group for Add-on modules\n    value: {get_resource: security_group}\n\n  keypair_name:\n    description: ID of the keypair for add-on modules\n    value: {get_param: key_pair_name}', 1,'HEAT base template','2017-10-17 11:00:00','MANUAL_RECORD');
INSERT INTO HEAT_TEMPLATE(ARTIFACT_UUID, NAME, VERSION, BODY, TIMEOUT_MINUTES, DESCRIPTION, CREATION_TIMESTAMP, ARTIFACT_CHECKSUM) VALUES
('e1588523-0087-4502-8779-0f3f94eef13c', 'onap_vnf_base.yaml','1', 'tosca_definitions_version: cloudify_dsl_1_3\n\ndescription: >\n  The blueprint describes an OpenStack vm created using Cloudify\n\nimports:\n  - https://cloudify.co/spec/cloudify/4.1m2/types.yaml\n  - plugin:cloudify-openstack-plugin?2.9.4001\n\ninputs:\n  openstack_config:\n    description: Openstack configuration structure\n  key_pair_name:\n    description: Openstack key pair name for the new server\n\nnode_templates:\n\n  security_group:\n    type: cloudify.openstack.nodes.SecurityGroup\n    properties:\n      openstack_config: { get_input: openstack_config }\n      rules:\n        - port: 80\n          remote_ip_prefix: 0.0.0.0/0\n        - port: 22\n          remote_ip_prefix: 0.0.0.0/0\n\n\n  keypair:\n    type: cloudify.openstack.nodes.KeyPair\n    properties:\n      openstack_config: { get_input: openstack_config }\n      use_external_resource: true\n      resource_id: { get_input: key_pair_name }\n      private_key_path: { concat: ["/etc/cloudify/", {get_input: key_pair_name}, ".pem"]}\n\noutputs:\n  secgroup_id:\n    description: ID of the security group for Add-on modules\n    value: {get_attribute: [security_group, external_id]}\n\n  keypair_id:\n    description: ID of the keypair for Add-on modules\n    value: {get_attribute: [keypair, external_id]}\n\n  keypair_name:\n    description: Name of the keypair for Add-on modules\n    value: {get_attribute: [keypair, external_name]}\n',3,'created from csar','2017-01-19 22:24:10','MANUAL RECORD');
--INSERT INTO HEAT_TEMPLATE(ARTIFACT_UUID, NAME, VERSION, BODY, TIMEOUT_MINUTES, DESCRIPTION, CREATION_TIMESTAMP, ARTIFACT_CHECKSUM) VALUES
--('e15ab762-0087-4502-8779-0f3f94eef13b', 'onap_vnf_addon.yaml','1',STRINGDECODE('tosca_definitions_version: cloudify_dsl_1_3\n\ndescription: >\n  The blueprint describes an OpenStack vm created using Cloudify\n\nimports:\n  - http://www.getcloudify.org/spec/cloudify/4.1m2/types.yaml\n  - plugin:cloudify-openstack-plugin?2.9.4001\n\ninputs:\n  openstack_config:\n    description: Openstack configuration structure\n  image:\n    description: Openstack image name or id for the new server (from Env)\n  flavor:\n    description: Openstack flavor name or id for the new server (from Env)\n  vm_name:\n    description: Name for the new VM\n  network_name:\n    description: Openstack network name the new server will be connected to\n  secgroup_id:\n    description: Openstack security group ID (from Base)\n  keypair_id:\n    description: Openstack keypair  ID (from Base)\n  keypair_name:\n    description: Openstack keypair Name (from Base)\n\nnode_templates:\n\n  security_group:\n    type: cloudify.openstack.nodes.SecurityGroup\n    properties:\n      openstack_config: { get_input: openstack_config }\n      use_external_resource: true\n      resource_id: { get_input: secgroup_id }\n\n  keypair:\n    type: cloudify.openstack.nodes.KeyPair\n    properties:\n      openstack_config: { get_input: openstack_config }\n      use_external_resource: true\n      resource_id: { get_input: keypair_id }\n      private_key_path: { concat: [\'/etc/cloudify/\', {get_input: keypair_name}, ".pem"]}\n\n  vm:\n    type: cloudify.openstack.nodes.Server\n    properties:\n      openstack_config: { get_input: openstack_config }\n      image: { get_input: image }\n      flavor: { get_input: flavor }\n      management_network_name: { get_input: network_name }\n      agent_config:\n        install_method: none\n    relationships:\n      - type: cloudify.openstack.server_connected_to_security_group\n        target: security_group\n      - type: cloudify.openstack.server_connected_to_keypair\n        target: keypair\n    interfaces:\n      cloudify.interfaces.lifecycle:\n        create:\n          inputs:\n            args:\n              name: { get_input: vm_name }\n              # security_groups: [{ get_attribute: [ security_group, external_name ]}]\n              # Is security group needed again when in relationships?\n\n\n'),3,'created from csar','2017-09-28 19:30:00','MANUAL RECORD');

-- For VduPlugin
INSERT INTO HEAT_TEMPLATE_PARAMS(HEAT_TEMPLATE_ARTIFACT_UUID, PARAM_NAME, IS_REQUIRED, PARAM_TYPE, PARAM_ALIAS) VALUES
('02188ab2-7cbb-4c55-bcd9-49a4dc9eb2ab','flavor','1','string',NULL),
('02188ab2-7cbb-4c55-bcd9-49a4dc9eb2ab','image','1','string',NULL),
('02188ab2-7cbb-4c55-bcd9-49a4dc9eb2ab','keypair_name','1','string',NULL),
('02188ab2-7cbb-4c55-bcd9-49a4dc9eb2ab','network_name','1','string',NULL),
('02188ab2-7cbb-4c55-bcd9-49a4dc9eb2ab','secgroup_id','1','string',NULL),
('02188ab2-7cbb-4c55-bcd9-49a4dc9eb2ab','vm_name','1','string',NULL),
('021c2d81-7cbb-4c55-bcd9-49a4dc9eb2ab','key_pair_name','1','string',NULL),
('021c2d81-7cbb-4c55-bcd9-49a4dc9eb2ab','vnf_name','1','string',NULL),
('e1588523-0087-4502-8779-0f3f94eef13c','key_pair_name','1','string',NULL);
--('e15ab762-0087-4502-8779-0f3f94eef13b','flavor','1','string',NULL),
--('e15ab762-0087-4502-8779-0f3f94eef13b','image','1','string',NULL),
--('e15ab762-0087-4502-8779-0f3f94eef13b','keypair_id','1','string',NULL),
--('e15ab762-0087-4502-8779-0f3f94eef13b','keypair_name','1','string',NULL),
--('e15ab762-0087-4502-8779-0f3f94eef13b','network_name','1','string',NULL),
--('e15ab762-0087-4502-8779-0f3f94eef13b','secgroup_id','1','string',NULL),
--('e15ab762-0087-4502-8779-0f3f94eef13b','vm_name','1','string',NULL);

-- For VduPlugin
INSERT INTO HEAT_ENVIRONMENT(ARTIFACT_UUID, NAME, VERSION, DESCRIPTION, BODY, CREATION_TIMESTAMP, ARTIFACT_CHECKSUM) VALUES
('0b188fb6-d0e5-4599-ad87-fc4e3a246ddf','heat_base.env','1','Manually generated HEAT Environment','\nparameters:\n  vnf_name:  xyz','2017-10-16 11:00:00','MANUAL RECORD'),
('0b198ff1-d0e5-4599-ad87-fc4e3a246ddf','heat_addon.env','1','Manually generated HEAT Environment','\nparameters:\n  flavor: m1.small \n  image:  CentOS 7\n','2017-10-16 11:00:00','MANUAL RECORD'),
('ff526790-2b31-4b0f-aa29-06d5e198cc42','onap_vnf_base.env','1','Auto-generated HEAT Environment deployment artifact','\nparameters:\n','2017-02-03 17:14:18','YTg5MTYyYWRjZjlkOGJhZGQ2MjE4ZTk5OTJkNWFjMmQ='),
('ff530087-2b31-4b0f-aa29-06d5e198cc42','onap_vnf_addon.env','1','Auto-generated HEAT Environment deployment artifact','\nparameters:\n  flavor: m1.small \n  image:  CentOS 7\n  TEST_vnf_id: \n','2017-02-03 17:14:18','YTg5MTYyYWRjZjlkOGJhZGQ2MjE4ZTk5OTJkNWFjMmQ=');

