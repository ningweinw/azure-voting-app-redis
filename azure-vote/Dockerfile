FROM ubuntu:18.04

# Environment configuration
ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    REDIS_URL=redis://localhost:6379/0 \
    PYTHONDONTWRITEBYTECODE=1

# Install Redis server + dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3.6 python3.6-venv python3-pip redis-server redis-tools redis ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install required Python packages
RUN python3.6 -m pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir Flask==1.1.4 redis==3.5.3

# Copy application code
COPY ./azure-vote /app

# Copy startup script
COPY ./start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

ENTRYPOINT ["/usr/local/bin/start.sh"]
