# import os

# project_name = "azure-policy-governance"

# list_of_paths = [
#     f"{project_name}/terraform/",
#     f"{project_name}/terraform/main.tf",
#     f"{project_name}/terraform/variables.tf",
#     f"{project_name}/terraform/outputs.tf",
#     f"{project_name}/terraform/providers.tf",
#     f"{project_name}/terraform/resource-groups.tf",
#     f"{project_name}/terraform/policies/",
#     f"{project_name}/terraform/policies/tag-policies.tf",
#     f"{project_name}/terraform/policies/initiative-definitions.tf",
#     f"{project_name}/terraform/policies/policy-assignments.tf",
#     f"{project_name}/terraform/compute/",
#     f"{project_name}/terraform/compute/virtual-machines.tf",
#     f"{project_name}/terraform/storage/",
#     f"{project_name}/terraform/storage/storage-accounts.tf",
#     f"{project_name}/.github/",
#     f"{project_name}/.github/workflows/",
#     f"{project_name}/.github/workflows/terraform-governance.yml",
#     f"{project_name}/scripts/",
#     f"{project_name}/scripts/setup.sh",
#     f"{project_name}/scripts/validate-compliance.sh",
#     f"{project_name}/README.md",
# ]

# for path in list_of_paths:
#     if path.endswith("/"):  
#         os.makedirs(path, exist_ok=True)
#     else:
#         dir_path = os.path.dirname(path)
#         if dir_path:
#             os.makedirs(dir_path, exist_ok=True)
#         with open(path, 'w') as f:
#             f.write("")  
#         print(f"Created file: {path}")

# #print(f"{list_of_paths} - Directories and files have been created.")
# print(f"\nProject structure for '{project_name}' has been created successfully!")
# print(f"Total items created: {len(list_of_paths)}")