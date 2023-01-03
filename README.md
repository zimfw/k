k
=

All kubectl aliases in one function. Also initializes kubectl completion if it
was not initialized.

```
usage: k <keys> [args...]
```

The keys parameter is composed of:
  * 1 command key
  * 0 or more resource keys
  * 0 or more option keys
  * 0 or 1 suffix key

all typed sequentially without spaces. Longer keys have precedence over shorter
keys. E.g `pvc` has precedence over `pv`.

### Commands
| Key | Command |
| --- | ------- |
| a | apply |
| c | create |
| d | describe |
| e | edit |
| g | get |
| h | help |
| k | kustomize |
| l | logs |
| t | top |
| v | version |
| x | delete |

### Resources
| Key | Resource |
| --- | -------- |
| apis  | apiservice |
| bi    | binding |
| cj    | cronjob |
| cm    | configmap |
| cr    | clusterrole |
| crb   | clusterrolebinding |
| crd   | customresourcedefinition |
| crv   | controllerrevision |
| cs    | componentstatus |
| csid  | csidriver |
| csin  | csinode |
| csisc | csistoragecapacity |
| csr   | certificatesigningrequest |
| de    | deployment |
| ds    | daemonset |
| ep    | endpoint |
| eps   | endpointslice |
| ev    | event |
| fs    | flowschema |
| hpa   | horizontalpodautoscaler |
| ic    | ingressclass |
| ing   | ingress |
| jo    | job |
| le    | lease |
| lr    | limitrange |
| lsarv | localsubjectaccessreview |
| mwc   | mutatingwebhookconfiguration |
| no    | node |
| np    | networkpolicy |
| ns    | namespace |
| pc    | priorityclass |
| pdb   | poddisruptionbudget |
| plc   | prioritylevelconfiguration |
| po    | pod |
| psp   | podsecuritypolicies |
| pt    | podtemplate |
| pv    | persistentvolume |
| pvc   | persistentvolumeclaim |
| rb    | rolebinding |
| rc    | replicationcontroller |
| ro    | role |
| rq    | resourcequota |
| rs    | replicaset |
| rtc   | runtimeclass |
| sa    | serviceaccount |
| sarv  | subjectaccessreview |
| sc    | storageclass |
| sec   | secret |
| ssarv | selfsubjectaccessreview |
| ssrrv | selfsubjectrulesreview |
| sts   | statefulset |
| svc   | service |
| tr    | tokenrequest |
| trv   | tokenreview |
| va    | volumeattachment |
| vo    | volume |
| vwc   | validatingwebhookconfiguration |

### Options
| Key | Option |
| --- | ------ |
| A  | --all-namespaces |
| a  | --all |
| h  | --help |
| oj | -o=json |
| on | -o=name |
| ow | -o=wide |
| oy | -o=yaml |
| sl | --show-labels |
| w  | --watch |

### Suffixes
| Key | Suffix |
| --- | ------ |
| f | -f |
| k | -k |
| l | -l |

Examples
--------
| Input | Output |
| ----- | ------ |
| `k af pod.json` | `kubectl apply -f pod.json` |
| `k dpol name=myLabel` | `kubectl describe pod -l name=myLabel` |
| `k gk dir/` | `kubectl get -k dir/` |
| `k gpoowA` | `kubectl get pod -o=wide --all-namespaces` |
| `k gsvcrc` | `kubectl get service,replicationcontroller` |
| `k xpoa` | `kubectl delete pod --all` |
