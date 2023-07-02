# This succeeds because it doesn't depend on other Python protos.
import subfolder.subfolder.subsubfolder.bridge_pb2
# This works.
from subfolder.subfolder.subsubfolder.bridge_pb2 import Bridge

# This fails. Python doesn't care about the 'package' directive in the proto.
from subfolder.subfolder.subsubfolder.bridge_pb2.package1 import Bridge

# This fails because python_proto_library doesn't match dependencies correctly.
import subfolder.subfolder.city_pb2
