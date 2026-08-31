import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> _recentSearches = [
    "Aroma Café",
    "Genesis Mall",
    "Port Harcourt Mall",
    "Domino's Pizza",
    "The Address Hotel",
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _removeSearch(String search) {
    setState(() {
      _recentSearches.remove(search);
    });
  }

  void _clearAllSearches() {
    setState(() {
      _recentSearches.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),

      appBar: AppBar(
        backgroundColor: const Color(0xffF7F8FC),
        elevation: 0,
        automaticallyImplyLeading: false,

        titleSpacing: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),

        title: const Text(
          "Search",
          style: TextStyle(
            color: Color(0xff171B26),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const SizedBox(height: 10),

            // Search field
            TextField(
              controller: _searchController,

              onSubmitted: (value) {
                if (value.trim().isEmpty) return;

                setState(() {
                  _recentSearches.remove(value.trim());
                  _recentSearches.insert(0, value.trim());
                });
              },

              decoration: InputDecoration(
                hintText: "Search businesses, places...",

                hintStyle: const TextStyle(
                  color: Color(0xff737784),
                  fontSize: 15,
                ),

                prefixIcon: const Icon(Icons.search, color: Color(0xff737784)),

                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                        icon: const Icon(Icons.close, color: Color(0xff737784)),
                      )
                    : null,

                filled: true,

                fillColor: const Color(0xffF1F3F7),

                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 15,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Color(0xff0A4FD6),
                    width: 1.2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Recent searches heading
            if (_recentSearches.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  const Text(
                    "Recent searches",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff171B26),
                    ),
                  ),

                  TextButton(
                    onPressed: _clearAllSearches,
                    child: const Text(
                      "Clear all",
                      style: TextStyle(
                        color: Color(0xff0A4FD6),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 8),

            // Recent searches
            Expanded(
              child: _recentSearches.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      itemCount: _recentSearches.length,

                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),

                      itemBuilder: (context, index) {
                        final search = _recentSearches[index];

                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),

                            border: Border.all(color: const Color(0xffEAECEF)),
                          ),

                          child: Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 3,
                              ),

                              leading: Container(
                                width: 42,
                                height: 42,

                                decoration: BoxDecoration(
                                  color: const Color(0xffEEF3FF),
                                  borderRadius: BorderRadius.circular(12),
                                ),

                                child: const Icon(
                                  Icons.history,
                                  color: Color(0xff0A4FD6),
                                  size: 21,
                                ),
                              ),

                              title: Text(
                                search,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff171B26),
                                ),
                              ),

                              trailing: IconButton(
                                onPressed: () {
                                  _removeSearch(search);
                                },

                                icon: const Icon(
                                  Icons.close,
                                  size: 19,
                                  color: Color(0xff737784),
                                ),
                              ),

                              onTap: () {
                                _searchController.text = search;
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Container(
              width: 70,
              height: 70,

              decoration: BoxDecoration(
                color: const Color(0xffEEF3FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.search,
                size: 34,
                color: Color(0xff0A4FD6),
              ),
            ),

            // Image(image: AssetImage('assets/images/search1.png'), height: 200),

            // Image.asset('assets/images/search2.png', width: 70, height: 70),
            // const SizedBox(height: 18),
            const Text(
              "Start searching",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff171B26),
              ),
            ),

            const SizedBox(height: 7),

            const Text(
              "Find businesses and places near you.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Color(0xff737784)),
            ),
          ],
        ),
      ),
    );
  }
}
