# This script generates a diagram of the platform-engineering-platform repository structure.
# It uses the 'diagrams' library, which is a high-level wrapper around graphviz.
#
# To run this script, you need to have graphviz and the diagrams library installed:
# pip install diagrams graphviz

from diagrams import Diagram, Cluster
from diagrams.onprem.vcs import Git
from diagrams.onprem.ci import GithubActions
from diagrams.programming.flowchart import Document
from diagrams.programming.language import Bash
from diagrams.onprem.iac import Terraform

with Diagram(
    "Platform Engineering Platform Repo Structure",
    show=False,
    filename="platform_engineering_platform_repo_diagram",
    outformat="png",
    direction="TB",
):
    git_repo = Git("Repo Root")

    with Cluster("Documentation"):
        readme = Document("README.md")
        license = Document("LICENSE")
        contributing = Document("CONTRIBUTING.md")
        get_started = Document("get-started-locally.md")
        stop_cluster = Document("stop-k3d-cluster.md")
        delete_repo = Document("delete-github-repo.md")

    with Cluster("CI/CD"):
        with Cluster(".github/workflows"):
            github_actions = GithubActions("terraform.yml")

    with Cluster("Scripts"):
        bootstrap_script = Bash("bootstrap-local.sh")

    with Cluster("Infrastructure as Code"):
        with Cluster("terraform"):
            terraform_config = Terraform("*.tf files")

    with Cluster("Cloud-specific Setup"):
        with Cluster("docs"):
            aws_setup = Document("aws-setup.md")
            gcp_setup = Document("gcp-setup.md")
            azure_setup = Document("azure-setup.md")

    # Relationships
    git_repo >> readme
    git_repo >> license
    git_repo >> contributing
    git_repo >> get_started
    git_repo >> stop_cluster
    git_repo >> delete_repo

    git_repo >> github_actions
    git_repo >> bootstrap_script
    git_repo >> terraform_config

    bootstrap_script >> aws_setup
    bootstrap_script >> gcp_setup
    bootstrap_script >> azure_setup
