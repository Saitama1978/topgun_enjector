import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Topgun Injector',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF005F73),
          elevation: 0,
        ),
      ),
      home: const SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _appsFilterEnabled = false;
  bool _dnsForwardingEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Section: Tunnel
          _buildSectionHeader('Tunnel'),
          _buildListTile(
            icon: Icons.cloud_outlined,
            title: 'Secure Shell (SSH)',
            onTap: () {},
          ),
          _buildListTile(
            icon: Icons.shield_outlined,
            title: 'V2Ray/Xray',
            onTap: () {},
          ),
          _buildListTile(
            icon: Icons.graphic_eq,
            title: 'Hysteria',
            onTap: () {},
          ),
          _buildListTile(
            icon: Icons.dns,
            title: 'DNSTT (DNS)',
            onTap: () {},
          ),
          _buildListTile(
            icon: Icons.send_outlined,
            title: 'Shadowsocks',
            onTap: () {},
          ),
          SwitchListTile(
            secondary: const Icon(Icons.assignment_turned_in_outlined, color: Colors.grey),
            title: const Text('Apps Filter', style: TextStyle(color: Colors.white, fontSize: 16)),
            value: _appsFilterEnabled,
            activeColor: const Color(0xFF00A896),
            onChanged: (bool value) {
              setState(() {
                _appsFilterEnabled = value;
              });
            },
          ),
          const Divider(color: Colors.white10, height: 20),

          // Section: General
          _buildSectionHeader('General'),
          ListTile(
            title: const Text('VPN DNS', style: TextStyle(color: Colors.white, fontSize: 16)),
            subtitle: const Text('Cloudflare DNS', style: TextStyle(color: Colors.grey)),
            onTap: () {},
          ),
          SwitchListTile(
            title: const Text('DNS Forwarding', style: TextStyle(color: Colors.white, fontSize: 16)),
            subtitle: const Text(
              'Enable to redirect all DNS queries to remote server, disable to resolved by local system',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            value: _dnsForwardingEnabled,
            activeColor: const Color(0xFF00A896),
            onChanged: (bool value) {
              setState(() {
                _dnsForwardingEnabled = value;
              });
            },
          ),
          const Divider(color: Colors.white10, height: 20),

          // Section: Connection
          _buildSectionHeader('Connection'),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF00A896),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildListTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
      onTap: onTap,
    );
  }
}
