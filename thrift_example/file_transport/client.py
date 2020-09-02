from thrift.transport import TSocket, TTransport
from thrift.protocol import TBinaryProtocol

from file import FileService
from file.ttypes import File


def main():
    transport = TSocket.TSocket('127.0.0.1', 9000)
    transport = TTransport.TBufferedTransport(transport)
    protocol = TBinaryProtocol.TBinaryProtocol(transport)
    client = FileService.Client(protocol)
    transport.open()
    fp = open('image.png', 'rb')
    file_name = fp.name
    buf = fp.read()
    res = client.uploadFile(File(name=f"new-{file_name}", buff=buf))
    print(f"result: {res}")
    transport.close()


if __name__ == '__main__':
    main()
