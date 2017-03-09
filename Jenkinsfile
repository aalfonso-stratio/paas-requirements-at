@Library('libpipelines@master') _

hose {
    EMAIL = 'qa'
    SLACKTEAM = 'stratioqa'
    MODULE = 'paasreqAT'
    REPOSITORY = 'paas-requirements-at'
    
    ATTIMEOUT = 10
    
    ATSERVICES = [
            ['DCOSCLI':   ['image': 'stratio/dcos-cli:0.4.15',
			   'volumes': ['stratio/paasintegrationpem:0.1.0'],
                           'env':     ['DCOS_IP=10.200.0.205',
                                      'SSL=true',
				      'SSH=true',
                                      'TOKEN_AUTHENTICATION=true',
                                      'DCOS_USER=admin@demo.stratio.com',
                                      'DCOS_PASSWORD=stratiotest',
                                      'BOOTSTRAP_USER=operador',
                                      'PEM_FILE_PATH=/paascerts/PaasIntegration.pem'],
                           'sleep':  10]]
        ]

    ATPARAMETERS = """
                    | -DDCOS_CLI_HOST=%%DCOSCLI#0
                    | -DDCOS_CLI_USER=root
                    | -DDCOS_CLI_PASSWORD=stratio
                    | """.stripMargin().stripIndent()

    AT = { config ->
        doAT(conf: config, groups: ['marathonlb'])
    }
}
