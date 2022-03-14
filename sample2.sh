#!/bin/bash
cat > demo-sample.sh <<'EOF'
#!/bin/bash
sleep 30
echo "Hello World from $(hostname)"
EOF
sudo chmod +x demo-sample.sh
sbatch sample2.sh
