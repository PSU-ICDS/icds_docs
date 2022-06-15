[Computing Services](https://www.icds.psu.edu/computing-services/)

# Roar Supercomputer Users’ Guide

### 0 We’re Redesigning the Roar User Guide!

We’re currently working to revise the Roar User Guide with updated content in an easier to use format, and we’d like your input!

All Roar users- students, faculty, and staff- are invited to take a brief, five minute survey to help us

[Click here to take our Roar User Guide survey.](https://pennstate.qualtrics.com/jfe/form/SV_7TBk5Pdt2rKiwTP) 


### Table of Contents

*   [0 We’re Redesigning the Roar User Guide!](#0-were-redesigning-the-roar-user-guide)
*   [1 Introduction](#01-00-introduction)
    *   [1.1 What is Roar?](#01-01-icds-aci)
    *   [1.2 What does Roar do?](#01-02-icds-aci)
    *   [1.3 Our Mission](#01-03-mission)
    *   [1.4 Our Vision](#01-04-vision)
*   [2 Roar History](#02-00-ics-aci-history)
*   [3 System Overview](#03-00-system-overview)
    *   [3.1 ACI-b](#03-01-aci-b)
    *   [3.2 ACI-I](#03-02-aci)
    *   [3.3 Roar Open Queue](#03-03-aci-open-queue)
    *   [3.4 HPRC](#03-04-hprc)
    *   [3.5 Filesystems](#03-05-filesystems)
    *   [3.6 Data Manager](#03-06-data-manager)
*   [4 System Access](#04-00-system-access)
    *   [4.1 Sponsorship](#04-01-sponsorship)
    *   [4.2 Permissions to use Resources](#04-02-permissions-use-resources)
    *   [4.3 Getting an Account](#04-03-getting-account)
*   [5 Basics of the Roar Resources](#05-00-basics-aci-resources)
    *   [5.1 System Usage](#05-01-system-usage)
    *   [5.2 Module System](#05-02-module-system)
    *   [5.3 Connecting to ACI-b](#05-03-connecting-aci-b)
    *   [5.4 Connecting to ACI-i](#05-04-connecting-aci)
        *   [5.4.1 Open OnDemand](#05-041-open-ondemand)
    *   [5.5 Connecting to HPRC](#05-05-connecting-to-hprc)
    *   [5.6 Transferring Data to and from Roar](#05-06-transferring-data-aci)
*   [6 Application Development](#06-00-application-development)
    *   [6.1 Version Control](#06-01-version-control)
    *   [6.2 Basic Compilation](#06-02-basic-compilation)
    *   [6.3 Libraries](#06-03-libraries)
*   [7 Running Jobs on ACI-b](#07-00-running-jobs-on-aci-b)
    *   [7.1 Requesting Resources](#07-01-requesting-resources)
    *   [7.2 Interactive Compute Sessions on ACI-b](#07-02-interactive-compute-sessions-aci-b)
    *   [7.3 PBS Environmental Variables](#07-03-pbs-environmental-variables)
    *   [7.4 GReaT Allocations](#07-04-great-allocations)
    *   [7.5 ACI-b GPU nodes](#07-05-aci-b-gpu-nodes)
*   [8 Running Jobs on HPRC](#08-00-running-jobs-on-hprc)
    *   [8.1 Requesting Resources](#08-01-requesting-resources)
        *   [8.1.1 Sample HPRC Batch Submission Script](#08-012-sample-script)
    *   [8.2 Interactive Compute Sessions on HPRC](#08-02-interactive-compute-sessions-on-hprc)
    *   [8.3 Requesting a Custom Singularity Container on HPRC](#08-03-requesting-a-custom-singularity-container-on-hprc)
    *   [8.4 Specifying a Custom Bash Environment on HPRC](#08-04-specifying-a-custom-bash-environment-on-hprc)
*   [9 Software Stack](#09-00-software-stack)
    *   [9.1 User Stack](#09-01-user-stack)
    *   [9.2 System Stack](#09-02-system-stack)
    *   [9.3 System Stack Applications](#09-03-system-stack-applications)
*   [10 Policies](#10-00-policies)
    *   [10.1 Authentication and Access Control](#10-01-authentication-access-control)
    *   [10.2 Data Protection and Retention](#10-02-data-protection-retention)
    *   [10.3 Software Acceptable Use](#10-03-software-acceptable-use)
    *   [10.4 SLA Terms and Conditions](#10-04-sla-terms-conditions)
*   [11 For Further Assistance](#11-00-for-further-assistance)

[Back to Top ▲](#jump-top)



[![Penn State Institute for Computational and Data Sciences Logo](https://www.icds.psu.edu/wp-content/themes/ics/assets/images/PSU_logo_white.png)](/) 

224B Computer Building  
[icds@psu.edu](mailto:icds@psu.edu)  
814-867-1467



About

*   [Overview](https://www.icds.psu.edu/about/)
*   [Staff](https://www.icds.psu.edu/about/meet-the-icds-team/icds-staff/)
*   [Careers](https://www.icds.psu.edu/careers/)
*   [Sitemap](https://www.icds.psu.edu/sitemap/)



i-ASK Support Center

*   [Account Set-Up](https://www.icds.psu.edu/computing-services/account-setup/)
*   [Roar Supercomputer User Guide](https://www.icds.psu.edu/computing-services/roar-user-guide/)
*   [i-ASK Help Center](https://www.icds.psu.edu/computing-services/support/)
*   814-865-4275



Sign Up for ICDS Announcements

*   [Subscribe to Our Mailing List](/subscribe)

Follow Us

*   [<span class="socicon socicon-twitter" style="padding: 10px; font-size: 14px; background-color: #4da7de"></span>](https://twitter.com/icds_psu)
*   [<span class="socicon socicon-youtube" style="padding: 10px; font-size: 14px; background-color: #e02a20"></span>](https://www.youtube.com/channel/UCnPq-88xAN4YeMbfD5_7Crg)
*   [<span class="socicon socicon-facebook" style="padding: 10px; font-size: 14px; background-color: #3e5b98"></span>](https://www.facebook.com/PennStateICDS/)
*   [<span class="socicon socicon-linkedin" style="padding: 10px; font-size: 14px; background-color: #3371b7"></span>](https://www.linkedin.com/company/penn-state-institute-for-computational-and-data-sciences)

[Penn State.](http://www.psu.edu/ "Penn State home page.") All rights reserved. [Privacy and Legal Statements](http://www.psu.edu/ur/legal.html)



