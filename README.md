<div align="center">
  <h1>⚡️ Simple and fast Python template ⚡️</h1>
  <strong>Pre-structure project to start coding right away</strong>
</div>

<p align="center">
  <a href="#requirements">Requirements</a>&nbsp;&nbsp;•&nbsp;
  <a href="#folders">Folder Structure</a>&nbsp;&nbsp;•&nbsp;
  <a href="#commands">Commands</a>&nbsp;&nbsp;•&nbsp;
  <a href="#packages">Dependencies</a>
</p>

<a name=requirements></a>
## Requirements

The project runs with [Python 3.12](https://www.python.org/downloads/release/python-3120/). 

The recommended way to install Python is using [pyenv](https://github.com/pyenv/pyenv) if you are on Linux or MacOS. Here is a summary of the steps,
but it's recommended to visit the documentation for more details.

<details><summary>Install Python with pyenv</summary>

1. Install pyenv:
    ```bash
    curl https://pyenv.run | bash
    ```

2. Set you bash profile to load pyenv. In my case I use fish:

    ```bash
    set -Ux PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
   ```
   
    Then, add the following line to `~/.config/fish/config.fish`:

    ```bash
    echo pyenv init - | source >> ~/.config/fish/config.fish
    ```
3. Install the selected Python version (you can see available version with `pyenv install --list`):
    ```bash
    pyenv install 3.12
    ```
4. Go to your project folder and select this Python version for the folder
    ```bash
    pyenv local 3.12
    ```
</details>

After installing _pyenv_ you only need to install the package manager, in this case I prefer
to use [pdm](https://github.com/pdm-project/pdm). Just need to run the following command on
your project folder:
    
```bash
pip install pdm
```

To install directly all dependencies, run:

```bash
make install
```

<a name=folders></a>
## Folder Structure

The project is structured following the [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) principles
and a bit of [Domain Driven Design](https://medium.com/@jonathanloscalzo/domain-driven-design-principios-beneficios-y-elementos-primera-parte-aad90f30aa35).

- The production code goes inside the `src` folder. Different modules are separated by *bounded_context* (you should rename this folder)
    - The `domain` folder contains the business rules, entities and value objects.
    - The `application` folder contains use cases and handlers
    - The `infra` folder contains the implementation of the interfaces defined in the domain for I/O operations like database, buses etc.
    - The `delivery` folder contains the entry points of the application, typically the controllers or routes of an API REST.
- The `tests` folder follows a similar structure to the production code.
    - The `domain` folder should contain mother objects and tests for the entities and value objects.
    - The `application` folder should contain tests for the use cases and handlers.
    - The `infra` folder should contain tests for the implementation of the interfaces defined in the domain.
    - The `delivery` folder should contain the acceptance or end-to-end tests.
- Inside `scripts` folder you can put any script utility like hooks, pre-defined commands etc.

<a name=commands></a>
## Make Commands

<a name=packages></a>
## Default Dependencies