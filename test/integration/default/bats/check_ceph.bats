DIR=/tmp/micro-ceph
export CEPH_CONF=${DIR}/ceph.conf

@test "check ceph status" {
    run ceph -c /tmp/micro-ceph/ceph.conf -s
    [[ ${lines[1]} =~ "HEALTH_OK" ]]
}

@test "check that it works" {
    run bash -c "rados lspools | grep -q data || rados mkpool data"
    [ $status = 0 ]
    run rados --pool data put group /etc/group
    [ $status = 0 ]
    run rados --pool data get group /tmp/group
    [ $status = 0 ]
    run diff /etc/group /tmp/group
    [ $status = 0 ]
}

@test "got the right version" {
      run ceph --version
      [ $status = 0 ]
      result="$output"
      run cat /tmp/ceph_version
      [[ $result =~ $output ]]
}
