#!/bin/bash
cat > demo-sample.sh <<'EOF'
#!/bin/bash
sleep 30
echo "Hello World from $(hostname)"
EOF
sudo chmod +x demo-sample.sh
awsbsub -jn demo -cf demo-sample.sh Luca
awsbstat
