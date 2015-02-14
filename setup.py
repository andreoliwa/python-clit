#!/usr/bin/env python
# -*- coding: utf-8 -*-
import clitoolkit


try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup


with open('README.rst') as readme_file:
    readme = readme_file.read()

with open('HISTORY.rst') as history_file:
    history = history_file.read().replace('.. :changelog:', '')

with open('requirements.txt') as txt_file:
    lines = txt_file.read()
requirements = [line for line in lines.split('\n') if '=' in line]

with open('requirements_dev.txt') as txt_file:
    lines = txt_file.read()
test_requirements = [line for line in lines.split('\n') if '=' in line]
test_requirements.extend(requirements)

setup(
    name='clitoolkit',
    version=clitoolkit.__version__,
    description="Several general use scripts to help in everyday life.",
    long_description=readme + '\n\n' + history,
    author="Wagner Augusto Andreoli",
    author_email='wagnerandreoli@gmail.com',
    url='https://github.com/wagnerandreoli/clitoolkit',
    packages=[
        'clitoolkit',
    ],
    package_dir={'clitoolkit':
                 'clitoolkit'},
    include_package_data=True,
    install_requires=requirements,
    license="BSD",
    zip_safe=False,
    keywords='clitoolkit',
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: BSD License',
        'Natural Language :: English',
        "Programming Language :: Python :: 2",
        'Programming Language :: Python :: 2.6',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.3',
        'Programming Language :: Python :: 3.4',
    ],
    test_suite='tests',
    tests_require=test_requirements
)