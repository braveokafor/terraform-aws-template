#!/usr/bin/env bash
while getopts a:n:u:d: flag
do
    case "${flag}" in
        a) author=${OPTARG};;
        n) name=${OPTARG};;
        d) description=${OPTARG};;
    esac
done

echo "Author: $author";
echo "Project Name: $name";
echo "Description: $description";

echo "Renaming project..."

original_author="braveokafor"
original_name="Terraform AWS Template"
original_description="Terraform template to bootstrap a baseline account on AWS."

for filename in $(git ls-files) 
do
    sed -i "s/$original_author/$author/g" $filename
    sed -i "s/$original_name/$name/g" $filename
    sed -i "s/$original_description/$description/g" $filename
    echo "Renamed $filename"
done


rm -rf .terraform-docs.yml .pre-commit-config.yaml CHANGELOG.md
rm -rf .github/bootstrap-repo.sh .github/workflows/release.yaml .github/workflows/bootstrap-repo.yaml

sed -i '/<!-- BEGIN_TEMPLATE_DOCUMENTATION -->/,/<!-- END_TEMPLATE_DOCUMENTATION -->/d' README.md
sed -i '/<!-- BEGIN_TF_DOCS -->/,/<!-- END_TF_DOCS -->/d' README.md