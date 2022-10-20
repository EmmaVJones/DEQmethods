library(remotes)
install_gitlab(repo = 'testpackage',
               host = 'http://gitlab.deq.virginia.gov')

https://gitlab.deq.virginia.gov/



  function (repo, subdir = NULL, auth_token = gitlab_pat(quiet),
            host = "gitlab.com", dependencies = NA, upgrade = c("default",
                                                                "ask", "always", "never"), force = FALSE,
            quiet = FALSE, build = TRUE, build_opts = c("--no-resave-data",
                                                        "--no-manual", "--no-build-vignettes"), build_manual = FALSE,
            build_vignettes = FALSE, repos = getOption("repos"),
            type = getOption("pkgType"), ...)
  {
    remotes <- lapply(repo, gitlab_remote, subdir = subdir, auth_token = auth_token,
                      host = host)
    install_remotes(remotes, auth_token = auth_token, host = host,
                    dependencies = dependencies, upgrade = upgrade, force = force,
                    quiet = quiet, build = build, build_opts = build_opts,
                    build_manual = build_manual, build_vignettes = build_vignettes,
                    repos = repos, type = type, ...)
  }


install_gitlab("https://gitlab.deq.virginia.gov/deq_water/wqm/testpackage")
install_git(url = 'https://gitlab.deq.virginia.gov/deq_water/wqm/testpackage')


# pass ssh key

creds = git2r::cred_ssh_key("C:\\Users\\wmu43954\\.ssh\\id_rsa.pub",
                            "C:\\Users\\wmu43954\\.ssh\\id_rsa")
devtools::install_git("git@gitlab.WORKDOMAIN.com:GITLABGROUP/PACKAGE.git",
                      credentials = creds)
