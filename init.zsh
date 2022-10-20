# if (( ! ${+functions[_kubectl]} )) source <(command kubectl completion zsh)

# Positional parameters:
# 1: name of input associative array
# 2: maximum key lenght in input associative array
# 3: optional, minimum key lenght, default is 1
_k_parse_token() {
  local -i klen
  local kval
  _kfound=0
  # Try longer keys first
  for klen in {$(( ${2} < ${#_kin} ? ${2} : ${#_kin} ))..${3:-1}}; do
    kval=${${(P)1}[${_kin:0:${klen}}]}
    if [[ -n ${kval} ]]; then
      _k_parsed+=(${kval})
      _kin=${_kin:${klen}}
      _kfound=1
      break
    fi
  done
}

_k_parse() {
  local -rA kcommands=(
    a  apply
    c  create
    d  describe
    e  edit
    g  get
    k  kustomize
    l  logs
    t  top
    x  delete
  )
  local -rA kresources=(
    apis  apiservice
    bi    binding
    cj    cronjob
    cm    configmap
    cr    clusterrole
    crb   clusterrolebinding
    crd   customresourcedefinition
    crv   controllerrevision
    cs    componentstatus
    csid  csidriver
    csin  csinode
    csisc csistoragecapacity
    csr   certificatesigningrequest
    de    deployment
    ds    daemonset
    ep    endpoint
    eps   endpointslice
    ev    event
    fs    flowschema
    hpa   horizontalpodautoscaler
    ic    ingressclass
    ing   ingress
    jo    job
    le    lease
    lr    limitrange
    lsarv localsubjectaccessreview
    mwc   mutatingwebhookconfiguration
    no    node
    np    networkpolicy
    ns    namespace
    pc    priorityclass
    pdb   poddisruptionbudget
    plc   prioritylevelconfiguration
    po    pod
    psp   podsecuritypolicies
    pt    podtemplate
    pv    persistentvolume
    pvc   persistentvolumeclaim
    rb    rolebinding
    rc    replicationcontroller
    ro    role
    rq    resourcequota
    rs    replicaset
    rtc   runtimeclass
    sa    serviceaccount
    sarv  subjectaccessreview
    sc    storageclass
    sec   secret
    ssarv selfsubjectaccessreview
    ssrrv selfsubjectrulesreview
    sts   statefulset
    svc   service
    tr    tokenrequest
    trv   tokenreview
    va    volumeattachment
    vo    volume
    vwc   validatingwebhookconfiguration
  )
  local -rA koptions=(
    A  --all-namespaces
    a  --all
    oj -o=json
    on -o=name
    ow -o=wide
    oy -o=yaml
    sl --show-labels
    w  --watch
  )
  local -rA ksuffixes=(
    f  -f
    k  -k
    l  -l
  )

  local _kin=${1}
  local -i _kfound
  typeset -ga _k_parsed
  _k_parsed=(kubectl)

  # Parse commands (1, required)
  _k_parse_token kcommands 1
  if (( ! _kfound )); then
    print -u2 -PR "unknown command: %B${_kin[1]}%b"
    return 2
  fi

  # Parse resources (0..n)
  local -i kpos=$(( ${#_k_parsed} + 1 ))
  while true; do
    _k_parse_token kresources 5 2
    if (( ! _kfound )) break
  done
  # Join resources with comma
  if (( kpos < ${#_k_parsed} )) _k_parsed[${kpos},-1]=(${(j:,:)_k_parsed[${kpos},-1]})

  # Parse options (0..n)
  while true; do
    _k_parse_token koptions 2
    if (( ! _kfound )) break
  done

  # Parse suffixes (0..1)
  _k_parse_token ksuffixes 1

  if [[ -n ${_kin} ]]; then
    print -u2 -PR "unknown token: %B${_kin}%b"
    return 2
  fi
}
