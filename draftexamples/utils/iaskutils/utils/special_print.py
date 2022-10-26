from rich.console import Console


def print_good(stdin):
    """Print text in bright_green."""
    console = Console()
    console.print("[bright_green]{}[/bright_green]".format(stdin))


def print_info(stdin):
    """Print text in deep_sky_blue1."""
    console = Console()
    console.print("[deep_sky_blue1]{}[/deep_sky_blue1]".format(stdin))


def print_bad(stdin):
    """Print text in red."""
    console = Console()
    console.print("[red]{}[/red]".format(stdin))


def important_info(stdin):
    """Print text in bold deep_sky_blue1."""
    console = Console()
    console.print("[bold deep_sky_blue1]{}[/bold deep_sky_blue1]".format(stdin))


def printrichtext(stdin):
    """Print text with only certain parts formatted by Rich API."""
    console = Console()
    console.print(stdin)
    