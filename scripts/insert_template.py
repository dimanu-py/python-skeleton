#!/usr/bin/env python3
import sys
from pathlib import Path

from scripts import templates


TEMPLATES = {
	"value_object": templates.value_object_template,
	"string_value_object": templates.string_value_object_template,
	"uuid": templates.uuid_template,
	"incorrect_value": templates.incorrect_value_error_template,
	"required_value": templates.required_value_error_template
}

def main() -> None:
	list_available_templates()
	template_name = input("Enter the name of the template you want to insert: ")
	ensure_template_exists(template_name)

	user_path = input("Enter the path where template should be created: ")
	file_path = generate_file_path(user_path, template_name)
	write_content_at(file_path, template_name)


def list_available_templates() -> None:
    print(f"Available templates: {', '.join(TEMPLATES.keys())}")


def ensure_template_exists(template_name: str) -> None:
	if template_name not in TEMPLATES:
		print(f"Error: Template '{template_name}' not found.")
		list_available_templates()
		sys.exit(1)


def write_content_at(file_path: Path, template_name: str) -> None:
	with open(file_path, "w") as file:
		file.write(TEMPLATES[template_name])
	print(f"Template {template_name} created at {file_path}")


def generate_file_path(user_path: str, template: str) -> Path:
	file_name = f"{template.replace('_template', '')}.py"
	folder_path = Path(user_path)
	file_path = folder_path / file_name

	project_root = Path(__file__).resolve().parent
	full_path =  project_root / file_path
	full_path.mkdir(parents=True, exist_ok=True)
	print(f"Folder created at: {full_path}")
	return full_path


if __name__ == "__main__":
	main()
