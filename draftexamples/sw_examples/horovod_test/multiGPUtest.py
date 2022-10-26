'''

-- Jan, 2020
'''

from __future__ import print_function
import argparse
import torch
import socket
import horovod.torch as hvd

# ## Training settings
parser = argparse.ArgumentParser(description='PyTorch RNN/FCN/PGNN Example')

# CUDA/seed/resume/evaluate setting #
parser.add_argument('--no-cuda', action='store_true', default=False,
                    help='disables CUDA training')
parser.add_argument('--fp16-allreduce', action='store_true', default=False,
                    help='use fp16 compression during allreduce')


def main():
    args = parser.parse_args()
    # ============== Horovod initialization Setting ============== #
    args.cuda = not args.no_cuda and torch.cuda.is_available()

    # ## Horovod: initialize library.
    hvd.init()
    if args.cuda:
        # ## Horovod: pin GPU to local rank.
        torch.cuda.set_device(hvd.local_rank())

    torch.backends.cudnn.benchmark = True
    # ## Horovod: limit # of CPU threads to be used per worker.
    torch.set_num_threads(torch.cuda.device_count())
    
    args.dtype = torch.float32
    device = torch.device("cuda:{}".format(hvd.local_rank()) if args.cuda else "cpu")
    host=socket.gethostname()
    print("rank:{:2d}, local rank: {}, device: {}, #GPU/node: {}".format(hvd.rank(), hvd.local_rank(), device, torch.cuda.device_count()))
    try:
        a = torch.tensor(1.).to(device)
        print("Successful send to host: {}, device:  {} on local rank: {} of rank:{:2d}".format(host, device, hvd.local_rank(), hvd.rank()))
    except:
        print("Failed send to host:{},  device: {} on local rank: {} of rank:{:2d}".format(host, device, hvd.local_rank(), hvd.rank()))


if __name__ == '__main__': 
    main()
