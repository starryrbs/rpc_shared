import time

from file import FileService
from file.ttypes import File
from thrift.transport import TSocket, TTransport
from thrift.protocol import TBinaryProtocol
from thrift.server import TServer

HOST = "localhost"
PORT = 9000


def time_sensor(func):
    def decorator(*args, **kwargs):
        start_time = time.time()
        result = func(*args, **kwargs)
        print(f"{func.__name__}耗时 {time.time() - start_time} 秒")
        return result

    return decorator


class FileServiceHandler:
    @time_sensor
    def uploadFile(self, file_data: File):
        with open(file_data.name, 'wb') as fp:
            fp.write(file_data.buff)

        return True


def start():
    handler = FileServiceHandler()
    processor = FileService.Processor(handler)
    transport = TSocket.TServerSocket("127.0.0.1", 9000)
    tfactory = TTransport.TBufferedTransportFactory()
    pfactory = TBinaryProtocol.TBinaryProtocolFactory()
    server = TServer.TSimpleServer(processor, transport, tfactory, pfactory)
    print(f"Starting thrift server in python...")
    server.serve()


if __name__ == '__main__':
    start()
