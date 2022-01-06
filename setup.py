import os

from setuptools import setup


HERE = os.path.abspath(os.path.dirname(__file__))


with open(os.path.join(HERE, 'README.md')) as f:
    long_description = f.read()

requirements = list()
with open(os.path.join(HERE, 'requirements.txt')) as f:
    for line in f:
        line = line.strip()
        if not line.startswith('#'):
            requirements.append(line)

package_names = list()
with open(os.path.join(HERE, "project-packages.txt")) as f:
    package_names = [line for line in f.read().split("\n")
                     if line and not line.startswith('#')]
package_name = package_names[0]

with open(os.path.join(HERE, 'version')) as f:
    version = f.read().strip()

setup(
    name=package_name,
    version=version,
    description=long_description,
    long_description=long_description,
    packages=package_names,
    include_package_data=True,
    install_requires=requirements,
    setup_requires=[

    ],
    tests_require=[

    ],
    data_files=[

    ],
    entry_points={
        'console_scripts': [
        ],
    },
    scripts=[
    ],
)
