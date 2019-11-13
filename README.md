# General Information

## Maintainer
Oliver Bründler [oliver.bruendler@psi.ch]

## License
This library is published under [PSI HDL Library License](License.txt), which is [LGPL](LGPL2_1.txt) plus some additional exceptions to clarify the LGPL terms in the context of firmware development.

## Detailed Documentation
For details, refer to the [Datasheet](doc/power_sink.pdf)

## Changelog
See [Changelog](Changelog.md)

<!-- DO NOT CHANGE FORMAT: this section is parsed to resolve dependencies -->

# Dependencies

The required folder structure looks as given below (folder names must be matched exactly). 

Alternatively the repository [psi\_fpga\_all](https://github.com/paulscherrerinstitute/psi_fpga_all) can be used. This repo contains all FPGA related repositories as submodules in the correct folder structure.

* TCL
  * [PsiIpPackage](https://github.com/paulscherrerinstitute/PsiIpPackage) (2.0.0, for development only )
* VHDL
  * [psi\_common](https://github.com/paulscherrerinstitute/psi_common) (2.5.0 or higher)
* VivadoIp
  * [**vivadoIP\_power\_sink**](https://github.com/paulscherrerinstitute/vivadoIP_power_sink)
  
<!-- END OF PARSED SECTION -->
  
Dependencies can also be checked out using the python script *scripts/dependencies.py*. For details, refer to the help of the script:

```
python dependencies.py -help
```

Note that the [dependencies package](https://github.com/paulscherrerinstitute/PsiFpgaLibDependencies) must be installed in order to run the script.

# Description
This IP-core allows toggline a configurable number of FFs, SRLs and BRAMs to drain power for testing purposes.

There is no simulation as the behavior is not easy to test in simulations (the most important thing is that nothing gets optimized away...).

 