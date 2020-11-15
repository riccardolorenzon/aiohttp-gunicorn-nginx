import multiprocessing
import os

workers = multiprocessing.cpu_count()

bind = '0.0.0.0:8080'
keepalive = 120
errorlog = '-'
pidfile = 'gunicorn.pid'

worker_class = 'aiohttp.GunicornWebWorker'
